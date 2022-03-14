import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlehack/cubit/countdown_timer/countdown_timer_cubit.dart';
import 'package:puzzlehack/models/sliding_tiles_puzzle.dart';
import 'package:puzzlehack/cubit/game_session/game_session_cubit.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/presentation/screens/puzzle_completed_popup.dart';
import 'package:puzzlehack/presentation/utils/animation_constants.dart';
import 'package:puzzlehack/presentation/utils/text_theme.dart';
import 'package:puzzlehack/presentation/widgets/puzzle_app_bar.dart';
import 'package:puzzlehack/presentation/widgets/puzzle_board.dart';

class PlayGame extends StatefulWidget {
  final GameSessionCubit gameSessionCubit;
  final AudioManagerCubit audioManagerCubit;
  final CountdownTimerCubit countdownTimerCubit;
  const PlayGame({
    Key? key,
    required this.gameSessionCubit,
    required this.audioManagerCubit,
    required this.countdownTimerCubit,
  }) : super(key: key);

  @override
  _PlayGameState createState() => _PlayGameState();
}

class _PlayGameState extends State<PlayGame> {
  @override
  void initState() {
    super.initState();

    if (widget.audioManagerCubit.state.musicEnabled) {
      widget.audioManagerCubit.audioDataDelegate.playGameSessionMusic();
    }

    if (widget.audioManagerCubit.state.soundsEnabled) {
      widget.audioManagerCubit.audioDataDelegate.playGameScramblingCountdown();
    }
    widget.gameSessionCubit.scrambleTiles();
  }

  @override
  void dispose() {
    widget.audioManagerCubit.audioDataDelegate.pauseGameSessionMusic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AudioManagerCubit>(
      create: (context) => widget.audioManagerCubit,
      child: Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: PuzzleAppBar(
          audioManagerCubit: widget.audioManagerCubit,
          isPlayingGame: true,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final gameWidget = Expanded(
              child: Center(
                child: BlocConsumer<GameSessionCubit, GameSessionState>(
                  bloc: widget.gameSessionCubit,
                  listener: (context, state) {
                    if (state is GameSessionOngoing &&
                        state.numberOfMoves == 0) {
                      widget.countdownTimerCubit.startCounting();
                    }

                    if (state is GameSessionOngoing && state.puzzle.isSolved) {
                      widget.gameSessionCubit.notifyPuzzleCompleted();
                    }

                    if (state is GameSessionEnded) {
                      widget.audioManagerCubit.audioDataDelegate
                          .pauseGameSessionMusic();

                      widget.audioManagerCubit.audioDataDelegate
                          .playPuzzleCompletedSound();

                      widget.countdownTimerCubit.stopCounting();

                      showDialog(
                        context: context,
                        barrierColor: Colors.orange.withOpacity(0.38),
                        barrierDismissible: false,
                        builder: (_) {
                          return PuzzleCompletedPopup(
                            puzzleCompletionTime: widget
                                    .countdownTimerCubit.state.elapsed
                                    .toString()
                                    .substring(2, 7)
                                    .replaceAll(":", " minutes and ") +
                                " seconds",
                            totalMoves: widget
                                .gameSessionCubit.state.numberOfMoves
                                .toString(),
                          );
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: PuzzleBoard(
                        cubit: widget.gameSessionCubit,
                        audioManagerCubit: widget.audioManagerCubit,
                      ),
                    );
                  },
                ),
              ),
            );

            final scoreWidget = Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: AnimationConstants.longDuration,
                      style: context.sizeAwareTextTheme.headline4!,
                      child: const Text(
                        "Puzzle Difficulty Level",
                      ),
                    ),
                    AnimatedDefaultTextStyle(
                      duration: AnimationConstants.longDuration,
                      style: context.sizeAwareTextTheme.subtitle2!
                          .copyWith(color: Colors.orange[600]),
                      child: Text(
                        describeEnum(widget.gameSessionCubit.puzzleDifficulty)
                            .toUpperCase(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    AnimatedDefaultTextStyle(
                      duration: AnimationConstants.longDuration,
                      style: context.sizeAwareTextTheme.headline4!,
                      child: const Text(
                        "Time Elapsed",
                      ),
                    ),
                    BlocBuilder<CountdownTimerCubit, CountdownTimerState>(
                      bloc: widget.countdownTimerCubit,
                      builder: (context, state) {
                        return AnimatedDefaultTextStyle(
                          duration: AnimationConstants.longDuration,
                          style: context.sizeAwareTextTheme.subtitle2!
                              .copyWith(color: Colors.orange[600]),
                          child: Text(
                            state.elapsed.toString().substring(2, 7),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    AnimatedDefaultTextStyle(
                      duration: AnimationConstants.longDuration,
                      style: context.sizeAwareTextTheme.headline4!,
                      child: const Text(
                        "Number Of Moves",
                      ),
                    ),
                    BlocBuilder<GameSessionCubit, GameSessionState>(
                      bloc: widget.gameSessionCubit,
                      builder: (context, state) {
                        return AnimatedDefaultTextStyle(
                          duration: AnimationConstants.longDuration,
                          style: context.sizeAwareTextTheme.subtitle2!
                              .copyWith(color: Colors.orange[600]),
                          child: Text(
                            state.numberOfMoves.toString(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );

            return Container(
              constraints: const BoxConstraints(minHeight: 200),
              child: AnimatedSwitcher(
                duration: AnimationConstants.shortestDuration,
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: constraints.maxWidth > constraints.maxHeight
                    ? Row(
                        children: [
                          gameWidget,
                          scoreWidget,
                        ],
                      )
                    : Column(
                        children: [
                          gameWidget,
                          scoreWidget,
                        ],
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
