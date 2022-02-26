import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlehack/core/puzzle/puzzle_difficulty.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/widgets/puzzle_selection_card.dart';

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
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "Select a difficulty level",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: List.generate(
                    PuzzleDifficulty.values.length,
                    (index) => Expanded(
                      child: PuzzleSelectionCard(
                        audioManagerCubit: widget.audioManagerCubit,
                        difficulty: PuzzleDifficulty.values[index],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
