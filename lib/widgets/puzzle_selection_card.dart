import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:puzzlehack/core/puzzle/puzzle_difficulty.dart';
import 'package:puzzlehack/core/puzzle_logic/cubit/game_session_cubit.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/screens/game_session_page.dart';

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
  }

  void onExit(PointerEvent details) {
    setState(() {
      isHovering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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

            widget.audioManagerCubit.audioDataDelegate.pausePreGameMusic();

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
              ).then((value) {
                widget.audioManagerCubit.audioDataDelegate.playPreGameMusic();
              }),
            );
          },
          child: AnimatedContainer(
            duration: animationDuration1,
            curve: animationCurve,
            color: isHovering ? Colors.orange[200] : Colors.grey[100],
            padding: isHovering
                ? const EdgeInsets.symmetric(horizontal: 10, vertical: 20)
                : const EdgeInsets.all(0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${widget.difficulty.puzzleDimension}×${widget.difficulty.puzzleDimension}",
                    style: isHovering
                        ? Theme.of(context).textTheme.headline3
                        : Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    "${(widget.difficulty.puzzleDimension * widget.difficulty.puzzleDimension) - 1} Tiles",
                    style: isHovering
                        ? Theme.of(context).textTheme.subtitle1
                        : Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(height: 20),
                  AnimatedContainer(
                    duration: animationDuration2,
                    curve: animationCurve,
                    decoration: BoxDecoration(
                      color: isHovering
                          ? Colors.orange
                          : Colors.orange.withOpacity(0),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: AnimatedOpacity(
                      opacity: isHovering ? 1 : 0,
                      duration: const Duration(milliseconds: 20),
                      child: Text(
                        describeEnum(widget.difficulty).toUpperCase(),
                        style: Theme.of(context).textTheme.button,
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
