import 'dart:ui';

import 'package:puzzlehack/core/puzzle/sliding_tiles_puzzle.dart';
import 'package:puzzlehack/core/puzzle/tile.dart';
import 'package:puzzlehack/view_models/puzzle_tile_view_model.dart';

class PuzzleViewModel {
  final Size puzzleCanvasSize;
  final SlidingTilesPuzzle puzzle;
  final String Function(PuzzleTile tile) displayDataDelegate;

  PuzzleViewModel(
    this.puzzleCanvasSize,
    this.puzzle,
    this.displayDataDelegate,
  ) {
    final double dimensionSize = puzzleCanvasSize.width / puzzle.dimension;
    size = Size(dimensionSize, dimensionSize);

    puzzleTiles = puzzle.tiles.map((tile) => tileViewModelFrom(tile)).toList();
  }

  late final List<PuzzleTileViewModel>
      puzzleTiles; // Make this a value listenable?
  late final Size size;

  
}

extension PVMX on PuzzleViewModel{
PuzzleTileViewModel tileViewModelFrom(PuzzleTile tile) {
    return PuzzleTileViewModel(
      tile.id,
      tile.currentPosition,
      displayDataDelegate(tile),
      size,
    );
  }
}