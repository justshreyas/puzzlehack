import 'dart:math';

import 'package:puzzlehack/core/puzzle/puzzle_grid_position.dart';
import 'package:puzzlehack/core/puzzle/tile.dart';

class SlidingTilesPuzzle {
  final int dimension;
  final List<PuzzleTile> tiles;
  final PuzzleGridPosition emptySpace;

  const SlidingTilesPuzzle(this.dimension, this.tiles, this.emptySpace);

  factory SlidingTilesPuzzle.solved(
    final int dimension,
  ) {
    final List<PuzzleTile> tiles = List.generate(
      dimension * dimension,
      (index) => PuzzleTile(
        index.toString(),
        PuzzleGridPosition(
          index % dimension,
          index ~/ dimension,
        ),
        PuzzleGridPosition(
          index % dimension,
          index ~/ dimension,
        ),
      ),
    );
    final PuzzleGridPosition emptySpace =
        PuzzleGridPosition(dimension, dimension);

    return SlidingTilesPuzzle(dimension, tiles, emptySpace);
  }

  factory SlidingTilesPuzzle.random(
    final int dimension,
  ) {
    final solvedPuzzle = SlidingTilesPuzzle.solved(dimension);
    return solvedPuzzle.scramble();
  }

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
  SlidingTilesPuzzle scramble() {
    SlidingTilesPuzzle mutablePuzzle = this;
    const int numberOfIterations = 1000;
    final randomizer = Random(numberOfIterations);

    for (var itr = 0; itr < numberOfIterations; itr++) {
      final int randomIndex = randomizer.nextInt(dimension * dimension);
      final candidate = mutablePuzzle.tiles.elementAt(randomIndex);
      if (mutablePuzzle.canMoveTile(candidate)) {
        mutablePuzzle.moveTile(candidate);
      }
    }

    return mutablePuzzle;
  }

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

extension SlidingTilesPuzzleViewX on SlidingTilesPuzzle {}
