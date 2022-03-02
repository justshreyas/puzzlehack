import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';

class PuzzleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AudioManagerCubit audioManagerCubit;
  final bool isPlayingGame;

  const PuzzleAppBar({
    Key? key,
    required this.audioManagerCubit,
    this.isPlayingGame = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(
        color: Colors.orange,
      ),
      elevation: 0,
      titleTextStyle: Theme.of(context).textTheme.headline6,
      actions: [
        BlocBuilder<AudioManagerCubit, AudioManagerState>(
          bloc: audioManagerCubit,
          builder: (context, state) {
            return IconButton(
              tooltip: "Toggle Background Music",
              onPressed: () {
                if (!state.musicEnabled) {
                  if (isPlayingGame) {
                    audioManagerCubit.audioDataDelegate.playGameSessionMusic();
                  } else {
                    audioManagerCubit.audioDataDelegate.playPreGameMusic();
                  }
                } else {
                  audioManagerCubit.audioDataDelegate.pauseGameSessionMusic();
                  audioManagerCubit.audioDataDelegate.pausePreGameMusic();
                }
                audioManagerCubit.toggleBackgroundMusic();
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
          bloc: audioManagerCubit,
          builder: (context, state) {
            return IconButton(
              tooltip: "Toggle Game Sounds",
              onPressed: () {
                audioManagerCubit.toggleSounds();
              },
              icon: Icon(state.soundsEnabled
                  ? Icons.touch_app_rounded
                  : Icons.do_not_touch_rounded),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(52);
}
