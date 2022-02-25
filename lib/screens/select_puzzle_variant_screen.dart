import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlehack/core/puzzle/tile.dart';
import 'package:puzzlehack/core/puzzle_logic/cubit/game_session_cubit.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/screens/game_session_page.dart';
import 'package:puzzlehack/view_models/puzzle_view_model.dart';

class SelectPuzzleVariantScreen extends StatefulWidget {
  final AudioManagerCubit audioManagerCubit;

  const SelectPuzzleVariantScreen({
    Key? key,
    required this.audioManagerCubit,
  }) : super(key: key);

  @override
  State<SelectPuzzleVariantScreen> createState() =>
      _SelectPuzzleVariantScreenState();
}

class _SelectPuzzleVariantScreenState extends State<SelectPuzzleVariantScreen> {
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
    if (widget.audioManagerCubit.state.musicEnabled) {
      widget.audioManagerCubit.audioDataDelegate.playPreGameMusic();
    }
  }

  @override
  void dispose() {
    widget.audioManagerCubit.audioDataDelegate.pausePreGameMusic();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Let's play"),
        titleTextStyle: Theme.of(context).textTheme.headline6,
        actions: [
          BlocBuilder<AudioManagerCubit, AudioManagerState>(
            bloc: widget.audioManagerCubit,
            builder: (context, state) {
              return IconButton(
                tooltip: "Toggle Background Music",
                onPressed: () {
                  widget.audioManagerCubit.toggleBackgroundMusic();
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
            bloc: widget.audioManagerCubit,
            builder: (context, state) {
              return IconButton(
                tooltip: "Toggle Game Sounds",
                onPressed: () {
                  widget.audioManagerCubit.toggleSounds();
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
          unawaited(widget.audioManagerCubit.audioDataDelegate
              .playComponentSelectedSound());

          final cubit = GameSessionCubit(
            configurator,
            size,
            dimension: 3,
            randomize: false,
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
        tooltip: 'Start the Game',
        label: const Text("START GAME"),
      ),
    );
  }
}
