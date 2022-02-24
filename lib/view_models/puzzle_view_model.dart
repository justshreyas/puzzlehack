import 'dart:ui';

import 'package:puzzlehack/core/puzzle/sliding_tiles_puzzle.dart';
import 'package:puzzlehack/core/puzzle/tile.dart';
import 'package:puzzlehack/view_models/puzzle_tile_view_model.dart';

enum DisplayDelegateViewConfigType { text, background }

class TileDisplayConfig {
  final DisplayDelegateViewConfigType type;
  final String value;

  TileDisplayConfig(this.type, this.value);
}

typedef DisplayDelegateConfigFunction = TileDisplayConfig Function(
    PuzzleTile tile);

class PuzzleViewModel {
  final Size puzzleCanvasSize;
  final SlidingTilesPuzzle puzzle;
  final DisplayDelegateConfigFunction displayDataDelegate;

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

  PuzzleViewModel copyWith({
    Size? puzzleCanvasSize,
    SlidingTilesPuzzle? puzzle,
    DisplayDelegateConfigFunction? displayDataDelegate,
    Size? size,
  }) {
    return PuzzleViewModel(
      puzzleCanvasSize ?? this.puzzleCanvasSize,
      puzzle ?? this.puzzle,
      displayDataDelegate ?? this.displayDataDelegate,
    );
  }
}

extension PVMX on PuzzleViewModel {
  PuzzleTileViewModel tileViewModelFrom(PuzzleTile tile) {
    return PuzzleTileViewModel(
      tile.id,
      tile.currentPosition,
      displayDataDelegate(tile).value, //TODO : Refactor inside tile
      size,
    );
  }
}
