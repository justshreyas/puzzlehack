import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/widgets/back_button.dart';

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
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const PuzzleBackButton(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<AudioManagerCubit, AudioManagerState>(
                  bloc: audioManagerCubit,
                  builder: (context, state) {
                    return IconButton(
                      tooltip: "Toggle Background Music",
                      onPressed: () {
                        if (!state.musicEnabled) {
                          if (isPlayingGame) {
                            audioManagerCubit.audioDataDelegate
                                .playGameSessionMusic();
                          } else {
                            audioManagerCubit.audioDataDelegate
                                .playPreGameMusic();
                          }
                        } else {
                          audioManagerCubit.audioDataDelegate
                              .pauseGameSessionMusic();
                          audioManagerCubit.audioDataDelegate
                              .pausePreGameMusic();
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
            )
          ],
        ));
    AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: PuzzleBackButton(),
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
  Size get preferredSize => const Size.fromHeight(100);
}
