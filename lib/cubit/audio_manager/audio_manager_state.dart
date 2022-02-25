part of 'audio_manager_cubit.dart';

@immutable
abstract class AudioManagerState {
  final bool musicEnabled;
  final bool soundsEnabled;

  const AudioManagerState(this.musicEnabled, this.soundsEnabled);
}

class AudioManagerInitial extends AudioManagerState {
  const AudioManagerInitial(bool musicEnabled, bool soundsEnabled)
      : super(musicEnabled, soundsEnabled);
}

class AudioManagerLoaded extends AudioManagerState {
  const AudioManagerLoaded(bool musicEnabled, bool soundsEnabled)
      : super(musicEnabled, soundsEnabled);
}
