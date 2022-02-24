import 'dart:math';

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

  Future<void> scrambleTiles(int numberOfScrambles) async {
    // * Start scrambling
    emit(GameSessionScrambling(state.model));

    final randomizer = Random(numberOfScrambles);
    final int dimension = state.model.puzzle.dimension;
    const delayDuration = Duration(milliseconds: 60);

    for (var itr = 0; itr < numberOfScrambles; itr++) {
      final int randomIndex = randomizer.nextInt((dimension * dimension) - 1);
      await Future.delayed(delayDuration, () {
        tryMovingATile(randomIndex);
      });
    }

    // * Stop scrambling and let user play
    emit(GameSessionOngoing(state.model));
  }

  @visibleForTesting
  void tryMovingATile(int randomIndex) {
    final mutablePuzzle = state.model.puzzle;
    final candidate = mutablePuzzle.tiles.elementAt(randomIndex);

    if (mutablePuzzle.canMoveTile(candidate)) {
      final changedPuzzle = mutablePuzzle.moveTile(candidate);

      emit(
        GameSessionScrambling(
          state.model.copyWith(
            puzzle: changedPuzzle,
          ),
        ),
      );
    }
  }

  void handleTileTapped(PuzzleTile tile) {
    if (state is GameSessionOngoing || state is GameSessionInitial) {
      final puzzle = state.model.puzzle;
      if (puzzle.canMoveTile(tile)) {
        final changedPuzzle = state.model.puzzle.moveTile(tile);

        if (changedPuzzle.isSolved) {
          emit(GameSessionEnded(state.model));
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
