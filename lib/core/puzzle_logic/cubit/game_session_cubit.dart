import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:puzzlehack/core/puzzle/sliding_tiles_puzzle.dart';
import 'package:puzzlehack/core/puzzle/tile.dart';

part 'game_session_state.dart';

class GameSessionCubit extends Cubit<GameSessionState> {
  GameSessionCubit({
    int dimension = 4,
    bool randomize = true,
  }) : super(
          GameSessionInitial(
            randomize
                ? SlidingTilesPuzzle.random(dimension)
                : SlidingTilesPuzzle.solved(dimension),
          ),
        );

  void handleTileTapped(PuzzleTile tile) {
    if (state is GameSessionOngoing) {
      final puzzle = state.puzzle;
      if (puzzle.canMoveTile(tile)) {
        emit(GameSessionOngoing(puzzle.moveTile(tile)));
      }
    }

    if (state.puzzle.isSolved) {
      GameSessionEnded(state.puzzle);
    }
  }
}
