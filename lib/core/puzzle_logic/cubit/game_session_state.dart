part of 'game_session_cubit.dart';

@immutable
abstract class GameSessionState {
  final SlidingTilesPuzzle puzzle;

  const GameSessionState(this.puzzle);
}

class GameSessionInitial extends GameSessionState {
  const GameSessionInitial(final SlidingTilesPuzzle puzzle) : super(puzzle);
}

class GameSessionOngoing extends GameSessionState {
  const GameSessionOngoing(final SlidingTilesPuzzle puzzle) : super(puzzle);
}

class GameSessionEnded extends GameSessionState {
  const GameSessionEnded(final SlidingTilesPuzzle puzzle) : super(puzzle);
}
