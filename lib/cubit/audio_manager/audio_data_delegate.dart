import 'package:just_audio/just_audio.dart';

class AudioDataDelegate {
  late final Map<String, AudioPlayer> players;

  static const List<String> mp3AssetNames = [
    "background-music",
    "countdown-timer",
    "option-click_or_hover",
    "option-select",
    "puzzle-solved",
    "start-game-music",
    "tile-tapped",
  ];

  Future<void> initialize() async {
    players = Map.fromIterable(mp3AssetNames, value: (_) => AudioPlayer());

    players.forEach(
      (assetName, player) async {
        await player.setAsset("/audio/$assetName.mp3", preload: true);
      },
    );

    return;
  }

  void dispose() {
    for (final player in players.values) {
      player.stop();
      player.dispose();
    }
  }

  Future<void> playPreGameMusic() async {
    final player = players.entries
        .firstWhere((entry) => entry.key == "start-game-music")
        .value;

    player.setLoopMode(LoopMode.one);

    return player.play();
  }

  Future<void> playGameScramblingCountdown() async {
    final player = players.entries
        .firstWhere((entry) => entry.key == "countdown-timer")
        .value;

    await player.play();

    await player.pause();
    await player.seek(Duration.zero);
  }

  Future<void> pausePreGameMusic() async {
    return players.entries
        .firstWhere((entry) => entry.key == "start-game-music")
        .value
        .pause();
  }

  Future<void> playGameSessionMusic() async {
    final player = players.entries
        .firstWhere((entry) => entry.key == "background-music")
        .value;

    await player.play();

    await player.setLoopMode(LoopMode.one);
    await player.seek(Duration.zero);
  }

  Future<void> pauseGameSessionMusic() async {
    return players.entries
        .firstWhere((entry) => entry.key == "background-music")
        .value
        .pause();
  }

  Future<void> playTileMovementSound() async {
    final player =
        players.entries.firstWhere((entry) => entry.key == "tile-tapped").value;

    await player.play();

    await player.pause();
    await player.seek(Duration.zero);
  }

  Future<void> playPuzzleCompletedSound() async {
    final player = players.entries
        .firstWhere((entry) => entry.key == "puzzle-solved")
        .value;

    await player.play();

    await player.pause();
    await player.seek(Duration.zero);
  }

  Future<void> playComponentHoveredSound() async {
    final player = players.entries
        .firstWhere((entry) => entry.key == "option-click_or_hover")
        .value;

    await player.play();

    await player.pause();
    await player.seek(Duration.zero);
  }

  Future<void> playComponentSelectedSound() async {
    final player = players.entries
        .firstWhere((entry) => entry.key == "option-select")
        .value;

    await player.play();

    await player.pause();
    await player.seek(Duration.zero);
  }
}
