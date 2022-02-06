import 'package:puzzlehack/core/puzzle/puzzle_grid_position.dart';
import 'package:puzzlehack/core/puzzle/tile.dart';

class SlidingTilesPuzzle {
  final int dimension;
  final List<PuzzleTile> tiles;
  final PuzzleGridPosition emptySpace;

  SlidingTilesPuzzle(this.dimension, this.tiles, this.emptySpace);

  SlidingTilesPuzzle copyWith({
    int? dimension,
    List<PuzzleTile>? tiles,
    PuzzleGridPosition? emptySpace,
  }) {
    return SlidingTilesPuzzle(
      dimension ?? this.dimension,
      tiles ?? this.tiles,
      emptySpace ?? this.emptySpace,
    );
  }
}

extension SlidingTilesPuzzleX on SlidingTilesPuzzle {
  bool get isSolved => tiles.every((t) => t.isInCorrectPosition);

  bool canMoveTile(PuzzleTile tile) {
    final bool horizontallyAdjacent =
        (tile.currentPosition.x - emptySpace.x).abs() == 1;

    final bool horizontallyCoinciding =
        (tile.currentPosition.y - emptySpace.y).abs() == 0;

    final bool verticallyAdjacent =
        (tile.currentPosition.y - emptySpace.y).abs() == 1;

    final bool verticallyCoinciding =
        (tile.currentPosition.x - emptySpace.x).abs() == 0;

    return (horizontallyAdjacent && verticallyCoinciding) ||
        (verticallyAdjacent && horizontallyCoinciding);
  }

  SlidingTilesPuzzle moveTile(PuzzleTile tile) {
    final movedTile = tile.copyWith(currentPosition: emptySpace);
    final mutableTiles = tiles;
    mutableTiles.remove(tile);
    mutableTiles.add(movedTile);

    return copyWith(
      tiles: mutableTiles,
      emptySpace: tile.currentPosition,
    );
  }
}
