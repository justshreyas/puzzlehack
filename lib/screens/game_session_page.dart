import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlehack/core/puzzle_logic/cubit/game_session_cubit.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
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
      // widget.audioManagerCubit.audioDataDelegate.playGameScramblingCountdown();
    }
    widget.gameSessionCubit.scrambleTiles(50);
  }

  @override
  void dispose() {
    widget.gameSessionCubit.dispose();
    widget.audioManagerCubit.audioDataDelegate.pauseGameSessionMusic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AudioManagerCubit>(
      create: (context) => widget.audioManagerCubit,
      child: Scaffold(
        body: Center(
          child: BlocBuilder<GameSessionCubit, GameSessionState>(
            bloc: widget.gameSessionCubit,
            builder: (context, state) {
              return PuzzleBoard(
                cubit: widget.gameSessionCubit,
              );
            },
          ),
        ),
      ),
    );
  }
}
