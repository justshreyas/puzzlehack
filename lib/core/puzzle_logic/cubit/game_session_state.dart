part of 'game_session_cubit.dart';

@immutable
abstract class GameSessionState {
  final PuzzleViewModel model;

  const GameSessionState(this.model);
}

class GameSessionInitial extends GameSessionState {
  const GameSessionInitial(final PuzzleViewModel model) : super(model);
}

class GameSessionScrambling extends GameSessionState {
  const GameSessionScrambling(final PuzzleViewModel model) : super(model);
}

class GameSessionOngoing extends GameSessionState {
  const GameSessionOngoing(final PuzzleViewModel model) : super(model);
}

class GameSessionEnded extends GameSessionState {
  const GameSessionEnded(final PuzzleViewModel model) : super(model);
}
