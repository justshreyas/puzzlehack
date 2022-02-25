import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlehack/core/puzzle/tile.dart';
import 'package:puzzlehack/core/puzzle_logic/cubit/game_session_cubit.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
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
  void initState() {
    super.initState();
    // final manager = context.read<AudioManagerCubit>();
    // if (manager.state.musicEnabled) {
    //   manager.audioDataDelegate.playPreGameMusic();
    // }
  }

  @override
  void dispose() {
    context.read<AudioManagerCubit>().audioDataDelegate.pausePreGameMusic();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        titleTextStyle: Theme.of(context).textTheme.headline6,
        actions: [
          BlocBuilder<AudioManagerCubit, AudioManagerState>(
            builder: (context, state) {
              return IconButton(
                tooltip: "Toggle Background Music",
                onPressed: () {
                  context.read<AudioManagerCubit>().toggleBackgroundMusic();
                },
                icon: Icon(
                  state.musicEnabled
                      ? Icons.music_note_rounded
                      : Icons.music_off_rounded,
                ),
              );
            },
          ),
          BlocBuilder<AudioManagerCubit, AudioManagerState>(
            builder: (context, state) {
              return IconButton(
                tooltip: "Toggle Game Sounds",
                onPressed: () {
                  context.read<AudioManagerCubit>().toggleSounds();
                },
                icon: Icon(state.soundsEnabled
                    ? Icons.touch_app_rounded
                    : Icons.do_not_touch_rounded),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "You'll be playing a $dimension x $dimension sliding tile puzzle",
                style: Theme.of(context).textTheme.headline3,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          unawaited(context
              .read<AudioManagerCubit>()
              .audioDataDelegate
              .playComponentSelectedSound());

          final cubit = GameSessionCubit(
            configurator,
            size,
            dimension: 3,
            randomize: false,
          );

          context
              .read<AudioManagerCubit>()
              .audioDataDelegate
              .pausePreGameMusic();

          unawaited(
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return GameSessionPage(
                    gameSessionCubit: cubit,
                  );
                },
              ),
            ),
          );
        },
        tooltip: 'Start the Game',
        label: const Text("START GAME"),
      ),
    );
  }
}
