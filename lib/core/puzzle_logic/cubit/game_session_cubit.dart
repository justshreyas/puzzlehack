import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';
import 'package:puzzlehack/core/puzzle/sliding_tiles_puzzle.dart';
import 'package:puzzlehack/core/puzzle/tile.dart';

part 'game_session_state.dart';

class GameSessionCubit extends Cubit<GameSessionState> {
 

  final tileClickedPlayer = AudioPlayer();
  // final backgroundMusicPlayer = AudioPlayer();
  final countdownMusicPlayer = AudioPlayer();

  GameSessionCubit(
    {
    int dimension = 4,
    bool randomize = true,
  }) : super(
          GameSessionInitial(
          
              randomize
                  ? SlidingTilesPuzzle.random(dimension)
                  : SlidingTilesPuzzle.solved(dimension),
             
          ),
        ) {
    // * Set+Load audio assets
    tileClickedPlayer.setAsset("/audio/tile-tapped.mp3");
    tileClickedPlayer.load();

    // backgroundMusicPlayer.setAsset("/audio/background-music.mp3");
    // backgroundMusicPlayer.load();

    countdownMusicPlayer.setAsset("/audio/countdown-timer.mp3");
    countdownMusicPlayer.load();
  }

  void dispose() {
    tileClickedPlayer.stop();
    tileClickedPlayer.dispose();

    countdownMusicPlayer.stop();
    countdownMusicPlayer.dispose();
  }

  Future<void> scrambleTiles(int numberOfScrambles) async {
    countdownMusicPlayer.play();

    // * Start scrambling
    emit(GameSessionScrambling(state.puzzle));

    final randomizer =
        Random(numberOfScrambles); //TODO : remove seed before perod
    final int dimension = state.puzzle.dimension;
    const delayDuration = Duration(milliseconds: 60);

    for (var itr = 0; itr < numberOfScrambles; itr++) {
      final int randomIndex = randomizer.nextInt((dimension * dimension) - 1);
      await Future.delayed(delayDuration, () {
        tryMovingATile(randomIndex);
      });
    }

    // * Stop scrambling and let user play

    Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        emit(GameSessionOngoing(state.puzzle));
      },
    );
  }

  @visibleForTesting
  void tryMovingATile(int randomIndex) {
    final mutablePuzzle = state.puzzle;
    final candidate = mutablePuzzle.tiles.elementAt(randomIndex);

    if (mutablePuzzle.canMoveTile(candidate)) {
      final changedPuzzle = mutablePuzzle.moveTile(candidate);

      emit(
        GameSessionScrambling(
         changedPuzzle
        
        ),
      );
    }
  }

  void handleTileTapped(PuzzleTile tile) {
    tileClickedPlayer.pause();
    tileClickedPlayer.seek(Duration.zero);

    if (state is GameSessionOngoing || state is GameSessionInitial) {
      final puzzle = state.puzzle;
      if (puzzle.canMoveTile(tile)) {
        final changedPuzzle = state.puzzle.moveTile(tile);

        if (changedPuzzle.isSolved) {
          emit(GameSessionEnded(state.puzzle));
        } else {
          emit(
            GameSessionOngoing(
         changedPuzzle
            ),
          );

          tileClickedPlayer.play();
        }
      }
    }
  }
}
