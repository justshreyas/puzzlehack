import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:puzzlehack/core/puzzle/puzzle_difficulty.dart';
import 'package:puzzlehack/core/puzzle_logic/cubit/game_session_cubit.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/screens/game_session_page.dart';
import 'package:puzzlehack/widgets/utils/animation_constants.dart';
import 'package:puzzlehack/widgets/utils/display_size.dart';
import 'package:puzzlehack/widgets/utils/layout_constants.dart';
import 'package:puzzlehack/widgets/utils/text_theme.dart';

class PuzzleSelectionCard extends StatefulWidget {
  final PuzzleDifficulty difficulty;
  final AudioManagerCubit audioManagerCubit;
  const PuzzleSelectionCard({
    Key? key,
    required this.difficulty,
    required this.audioManagerCubit,
  }) : super(key: key);

  @override
  _PuzzleSelectionCardState createState() => _PuzzleSelectionCardState();
}

class _PuzzleSelectionCardState extends State<PuzzleSelectionCard> {
  bool isHovering = false;

  static const animationCurve = Curves.easeIn;

  @override
  void initState() {
    super.initState();
  }

  void onEnter(PointerEvent details) {
    setState(() {
      isHovering = true;
    });

    if (widget.audioManagerCubit.state.soundsEnabled) {
      widget.audioManagerCubit.audioDataDelegate.playComponentHoveredSound();
    }
  }

  void onExit(PointerEvent details) {
    setState(() {
      isHovering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final displaySize = MediaQuery.of(context).size.displaySize;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: onEnter,
      onExit: onExit,
      child: AnimatedPadding(
        duration: AnimationConstants.shortDuration,
        curve: animationCurve,
        padding: isHovering
            ? const EdgeInsets.all(0)
            : LayoutConstants.componentOnHoverPadding(displaySize),
        child: GestureDetector(
          onTap: () {
            unawaited(widget.audioManagerCubit.audioDataDelegate
                .playComponentSelectedSound());

            final cubit = GameSessionCubit(
              puzzleDifficulty: widget.difficulty,
            );

            unawaited(
                widget.audioManagerCubit.audioDataDelegate.pausePreGameMusic());

            unawaited(
              Navigator.push(
                context,
                MaterialPageRoute(
                  settings: const RouteSettings(name: "/GameSessionPage"),
                  builder: (_) {
                    return GameSessionPage(
                      gameSessionCubit: cubit,
                      audioManagerCubit: widget.audioManagerCubit,
                    );
                  },
                ),
              ).then(
                (value) {
                  if (widget.audioManagerCubit.state.musicEnabled) {
                    widget.audioManagerCubit.audioDataDelegate
                        .playPreGameMusic();
                  }
                },
              ),
            );
          },
          child: AnimatedContainer(
            duration: AnimationConstants.shortDuration,
            curve: animationCurve,
            decoration: BoxDecoration(
              color: isHovering ? Colors.orange : Colors.white70,
            ),
            padding: isHovering
                ? LayoutConstants.componentOnHoverPadding(displaySize)
                : const EdgeInsets.all(0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: AnimatedDefaultTextStyle(
                  duration: AnimationConstants.shortDuration,
                  style: context.sizeAwareTextTheme.button!.copyWith(
                    color: isHovering ? Colors.white : Colors.orange[600],
                  ),
                  child: Text(
                    describeEnum(widget.difficulty).toUpperCase(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
