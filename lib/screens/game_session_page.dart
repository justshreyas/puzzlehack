import 'package:flutter/material.dart';
import 'package:puzzlehack/core/puzzle_logic/cubit/game_session_cubit.dart';

class GameSessionPage extends StatefulWidget {
  final GameSessionCubit gameSessionCubit;
  const GameSessionPage({
    Key? key,
    required this.gameSessionCubit,
  }) : super(key: key);

  @override
  _GameSessionPageState createState() => _GameSessionPageState();
}

class _GameSessionPageState extends State<GameSessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(),
      ),
    );
  }
}
