import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlehack/core/puzzle/sliding_tiles_puzzle.dart';
import 'package:puzzlehack/core/puzzle_logic/cubit/game_session_cubit.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/widgets/puzzle_app_bar.dart';
import 'package:puzzlehack/widgets/puzzle_board.dart';

class GameSessionPage extends StatefulWidget {
  final GameSessionCubit gameSessionCubit;
  final AudioManagerCubit audioManagerCubit;
  const GameSessionPage({
    Key? key,
    required this.gameSessionCubit,
    required this.audioManagerCubit,
  }) : super(key: key);

  @override
  _GameSessionPageState createState() => _GameSessionPageState();
}

class _GameSessionPageState extends State<GameSessionPage> {
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
                    if (state is GameSessionOngoing && state.puzzle.isSolved) {
                      widget.gameSessionCubit.notifyPuzzleCompleted();
                    }

                    if (state is GameSessionEnded) {
                      widget.audioManagerCubit.audioDataDelegate
                          .pauseGameSessionMusic();

                      widget.audioManagerCubit.audioDataDelegate
                          .playPuzzleCompletedSound();

                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text(
                              "Wohoo!",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            content: Text(
                              "You made it! You solved the puzzle",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            actions: [
                              FloatingActionButton.extended(
                                label: Text(
                                  "GO BACK",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                onPressed: () {
                                  Navigator.popUntil(
                                    context,
                                    (route) =>
                                        route.settings.name ==
                                        "/SelectPuzzleVariantScreen",
                                  );
                                },
                              )
                            ],
                          );
                        },
                        barrierDismissible: false,
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
                  Text(
                    "Level : E/M/H",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    "Time Elapsed : XXm YYs",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    "Number of moves : ZZ",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ));

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 50),
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
            );
          },
        ),
      ),
    );
  }
}
