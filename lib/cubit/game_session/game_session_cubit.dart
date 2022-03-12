import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:puzzlehack/models/puzzle_difficulty.dart';
import 'package:puzzlehack/models/sliding_tiles_puzzle.dart';
import 'package:puzzlehack/models/tile.dart';
import 'package:puzzlehack/presentation/utils/animation_constants.dart';

part 'game_session_state.dart';

class GameSessionCubit extends Cubit<GameSessionState> {
  final PuzzleDifficulty puzzleDifficulty;
  int _numberOfMoves = 0;
  GameSessionCubit({
    required this.puzzleDifficulty,
  }) : super(
          GameSessionInitial(
            puzzleDifficulty.randomizeAtStart
                ? SlidingTilesPuzzle.random(puzzleDifficulty.puzzleDimension)
                : SlidingTilesPuzzle.solved(puzzleDifficulty.puzzleDimension),
            0,
          ),
        );

  Future<void> onlyScrambleTiles() async {
    final numberOfScrambles = puzzleDifficulty.numberOfScrambles;

    // * Start scrambling
    emit(GameSessionScrambling(state.puzzle, _numberOfMoves));

    final randomizer = Random();
    final int dimension = puzzleDifficulty.puzzleDimension;

    for (var itr = 0; itr < numberOfScrambles; itr++) {
      final int randomIndex = randomizer.nextInt((dimension * dimension) - 1);
      await tryMovingATile(randomIndex);
    }
  }

  Future<void> scrambleTiles() async {
    await onlyScrambleTiles();

    // * Stop scrambling and let user play
    Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        emit(GameSessionOngoing(state.puzzle, _numberOfMoves));
      },
    );
  }

  @visibleForTesting
  Future<void> tryMovingATile(int randomIndex) async {
    final mutablePuzzle = state.puzzle;
    final candidate = mutablePuzzle.tiles.elementAt(randomIndex);
    const delayDuration = AnimationConstants.mediumDuration;

    if (mutablePuzzle.canMoveTile(candidate)) {
      final changedPuzzle = mutablePuzzle.moveTile(candidate);

      await Future.delayed(
        delayDuration,
        () {
          emit(
            GameSessionScrambling(changedPuzzle, _numberOfMoves),
          );
        },
      );
    }
  }

  bool handleTileTapped(PuzzleTile tile) {
    if (state is GameSessionOngoing || state is GameSessionInitial) {
      final puzzle = state.puzzle;
      if (puzzle.canMoveTile(tile)) {
        final changedPuzzle = state.puzzle.moveTile(tile);
        _numberOfMoves++;
        emit(
          GameSessionOngoing(changedPuzzle, _numberOfMoves),
        );

        return true;
      }
    }
    return false;
  }

  void notifyPuzzleCompleted() {
    emit(GameSessionEnded(state.puzzle, _numberOfMoves));
  }
}
