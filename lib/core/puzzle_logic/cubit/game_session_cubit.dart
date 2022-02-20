import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:puzzlehack/core/puzzle/sliding_tiles_puzzle.dart';
import 'package:puzzlehack/core/puzzle/tile.dart';
import 'package:puzzlehack/view_models/puzzle_view_model.dart';

part 'game_session_state.dart';

class GameSessionCubit extends Cubit<GameSessionState> {
  final DisplayDelegateConfigFunction delegateConfigurator;
  Size size;
  GameSessionCubit(
    this.delegateConfigurator,
    this.size, {
    int dimension = 4,
    bool randomize = true,
  }) : super(
          GameSessionInitial(
            PuzzleViewModel(
              size,
              randomize
                  ? SlidingTilesPuzzle.random(dimension)
                  : SlidingTilesPuzzle.solved(dimension),
              delegateConfigurator,
            ),
          ),
        );

  void handleTileTapped(PuzzleTile tile) {
    if (state is GameSessionOngoing || state is GameSessionInitial) {
      final puzzle = state.model.puzzle;
      if (puzzle.canMoveTile(tile)) {
        final changedPuzzle = state.model.puzzle.moveTile(tile);

        if (changedPuzzle.isSolved) {
         emit (GameSessionEnded(state.model));
        } else {
          emit(
            GameSessionOngoing(
              state.model.copyWith(puzzle: changedPuzzle),
            ),
          );
        }
      }
    }
  }
}
