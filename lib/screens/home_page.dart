import 'package:flutter/material.dart';
import 'package:puzzlehack/core/puzzle/tile.dart';
import 'package:puzzlehack/core/puzzle_logic/cubit/game_session_cubit.dart';
import 'package:puzzlehack/screens/game_session_page.dart';
import 'package:puzzlehack/view_models/puzzle_view_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int dimension = 3;
  int scrambleIterations = 10;

  TileDisplayConfig configurator(PuzzleTile tile) {
    return TileDisplayConfig(
      DisplayDelegateViewConfigType.text,
      tile.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "You'll be playing a $dimension x $dimension sliding tile puzzle",
              style: Theme.of(context).textTheme.headline3,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final cubit = GameSessionCubit(
            configurator,
            size,
            dimension: 3,
            randomize: false,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return GameSessionPage(
                  gameSessionCubit: cubit,
                );
              },
            ),
          );
        },
        tooltip: 'Start the Game',
        label: const Text("START GAME"),
      ),
    );
  }
}
