part of 'game_session_cubit.dart';

@immutable
abstract class GameSessionState {
  final SlidingTilesPuzzle puzzle;
  final int numberOfMoves;
  const GameSessionState(this.puzzle, this.numberOfMoves);
}

class GameSessionInitial extends GameSessionState {
  const GameSessionInitial(
    final SlidingTilesPuzzle puzzle,
    final int numberOfMoves,
  ) : super(puzzle, numberOfMoves);
}

class GameSessionScrambling extends GameSessionState {
  const GameSessionScrambling(
    final SlidingTilesPuzzle puzzle,
    final int numberOfMoves,
  ) : super(puzzle, numberOfMoves);
}

class GameSessionOngoing extends GameSessionState {
  const GameSessionOngoing(
    final SlidingTilesPuzzle puzzle,
    final int numberOfMoves,
  ) : super(puzzle, numberOfMoves);
}

class GameSessionEnded extends GameSessionState {
  const GameSessionEnded(
    final SlidingTilesPuzzle puzzle,
    final int numberOfMoves,
  ) : super(puzzle, numberOfMoves);
}
