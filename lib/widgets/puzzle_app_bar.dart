import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/widgets/back_button.dart';
import 'package:puzzlehack/widgets/info_button.dart';
import 'package:puzzlehack/widgets/settings_button.dart';

class PuzzleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AudioManagerCubit audioManagerCubit;
  final bool isPlayingGame;
  final bool showBackButton;
  final bool showActions;

  const PuzzleAppBar({
    Key? key,
    required this.audioManagerCubit,
    this.isPlayingGame = false,
    this.showBackButton = true,
    this.showActions = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // * Leading
        if(showBackButton)  PuzzleBackButton(
            audioManagerCubit: audioManagerCubit,
          ),

          if(!showBackButton)PuzzleInfoButton(
                        audioManagerCubit: audioManagerCubit,

          ),

          // * Actions
         if(showActions)    Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // * Music
              BlocBuilder<AudioManagerCubit, AudioManagerState>(
                bloc: audioManagerCubit,
                builder: (context, state) {
                  return PuzzleSettingsToggleButton(
                    audioManagerCubit: audioManagerCubit,
                    enabled: state.musicEnabled,
                    enabledIcon: Icons.music_note_rounded,
                    disabledIcon: Icons.music_off_rounded,
                    onTap: () {
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
                        audioManagerCubit.audioDataDelegate.pausePreGameMusic();
                      }
                      audioManagerCubit.toggleBackgroundMusic();
                    },
                  );
                },
              ),

              // * Sounds
              BlocBuilder<AudioManagerCubit, AudioManagerState>(
                bloc: audioManagerCubit,
                builder: (context, state) {
                  return PuzzleSettingsToggleButton(
                    audioManagerCubit: audioManagerCubit,
                    enabled: state.soundsEnabled,
                    enabledIcon: Icons.volume_up_rounded,
                    disabledIcon: Icons.volume_off_rounded,
                    onTap: () {
                      audioManagerCubit.toggleSounds();
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
