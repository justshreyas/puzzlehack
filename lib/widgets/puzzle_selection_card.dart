import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:puzzlehack/core/puzzle/puzzle_difficulty.dart';
import 'package:puzzlehack/core/puzzle_logic/cubit/game_session_cubit.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/screens/game_session_page.dart';
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

  static const animationDuration1 = Duration(milliseconds: 100);
  static const animationDuration2 = Duration(milliseconds: 20);
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
    final double cardHeight = MediaQuery.of(context).size.height;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: onEnter,
      onExit: onExit,
      child: AnimatedPadding(
        duration: animationDuration1,
        curve: animationCurve,
        padding: isHovering
            ? const EdgeInsets.all(0)
            : const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
            duration: animationDuration1,
            curve: animationCurve,
            decoration: BoxDecoration(
              color: isHovering ? Colors.orange[200] : Colors.grey[100],
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            padding: isHovering
                ? const EdgeInsets.symmetric(horizontal: 10, vertical: 20)
                : const EdgeInsets.all(0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 150),
                    style: isHovering
                        ? context.sizeAwareTextTheme.headline2!
                        : context.sizeAwareTextTheme.headline3!,
                    child: Text(
                      "${widget.difficulty.puzzleDimension}×${widget.difficulty.puzzleDimension}",
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: animationDuration2,
                    child: isHovering
                        ? AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 150),
                            style: context.sizeAwareTextTheme.subtitle1!,
                            child: Text(
                              "${(widget.difficulty.puzzleDimension * widget.difficulty.puzzleDimension) - 1} Tiles",
                            ),
                          )
                        : const SizedBox.shrink(),
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                  AnimatedPadding(
                    duration: animationDuration1,
                    padding: isHovering
                        ? const EdgeInsets.only(top: 20.0)
                        : const EdgeInsets.all(10.0),
                    child: AnimatedContainer(
                      duration: animationDuration2,
                      curve: animationCurve,
                      decoration: BoxDecoration(
                        color: isHovering ? Colors.orange[600] : Colors.orange,
                      ),
                      padding: isHovering
                          ? const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10)
                          : const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 150),
                        style: context.sizeAwareTextTheme.button!
                            .copyWith(fontSize: cardHeight * 0.03),
                        child: Text(
                          describeEnum(widget.difficulty).toUpperCase(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
