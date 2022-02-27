import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_data_delegate.dart';

part 'audio_manager_state.dart';

class AudioManagerCubit extends Cubit<AudioManagerState> {
  final AudioDataDelegate audioDataDelegate;
  AudioManagerCubit(this.audioDataDelegate)
      : super(const AudioManagerInitial(true, true)) {
    audioDataDelegate.initialize();
  }

  void toggleBackgroundMusic() {
    final isMusicEnabled = state.musicEnabled;
    final areSoundsEnabled = state.soundsEnabled;

    emit(AudioManagerLoaded(!isMusicEnabled, areSoundsEnabled));
  }

  void toggleSounds() {
    final isMusicEnabled = state.musicEnabled;
    final areSoundsEnabled = state.soundsEnabled;

   
    emit(AudioManagerLoaded(isMusicEnabled, !areSoundsEnabled));
  }
}
