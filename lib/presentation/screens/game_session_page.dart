import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlehack/models/sliding_tiles_puzzle.dart';
import 'package:puzzlehack/cubit/game_session/game_session_cubit.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/presentation/screens/puzzle_completed_popup.dart';
import 'package:puzzlehack/presentation/utils/animation_constants.dart';
import 'package:puzzlehack/presentation/utils/text_theme.dart';
import 'package:puzzlehack/presentation/widgets/puzzle_app_bar.dart';
import 'package:puzzlehack/presentation/widgets/puzzle_board.dart';

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
                        barrierColor: Colors.orange.withOpacity(0.54),
                        barrierDismissible: false,
                        builder: (_) {
                          return const PuzzleCompletedPopup();
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
                      "Level : E/M/H",
                    ),
                  ),
                  AnimatedDefaultTextStyle(
                    duration: AnimationConstants.longDuration,
                    style: context.sizeAwareTextTheme.headline4!,
                    child: const Text(
                      "Time Elapsed : XXm YYs",
                    ),
                  ),
                  AnimatedDefaultTextStyle(
                    duration: AnimationConstants.longDuration,
                    style: context.sizeAwareTextTheme.headline4!,
                    child: const Text(
                      "Number of moves : ZZ",
                    ),
                  ),
                ],
              ),
            ));
            return AnimatedSwitcher(
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
            );
          },
        ),
      ),
    );
  }
}
