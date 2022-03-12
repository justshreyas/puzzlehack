import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlehack/cubit/countdown_timer/countdown_timer_cubit.dart';
import 'package:puzzlehack/cubit/game_session/game_session_cubit.dart';
import 'package:puzzlehack/presentation/utils/animation_constants.dart';
import 'package:puzzlehack/presentation/utils/text_theme.dart';

class GameSessionInfo extends StatelessWidget {
  final GameSessionCubit gameSessionCubit;
  final CountdownTimerCubit countdownTimerCubit;

  const GameSessionInfo({
    Key? key,
    required this.gameSessionCubit,
    required this.countdownTimerCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        BlocBuilder<CountdownTimerCubit, CountdownTimerState>(
          bloc: countdownTimerCubit,
          builder: (context, state) {
            return AnimatedDefaultTextStyle(
              duration: AnimationConstants.longDuration,
              style: context.sizeAwareTextTheme.headline4!,
              child: Text(
                "Time Elapsed : ${state.elapsed.toString().substring(2, 7)}",
              ),
            );
          },
        ),
        BlocBuilder<GameSessionCubit, GameSessionState>(
          bloc: gameSessionCubit,
          builder: (context, state) {
            return AnimatedDefaultTextStyle(
              duration: AnimationConstants.longDuration,
              style: context.sizeAwareTextTheme.headline4!,
              child: const Text(
                "Number of moves : ZZ",
              ),
            );
          },
        ),
      ],
    );
  }
}
