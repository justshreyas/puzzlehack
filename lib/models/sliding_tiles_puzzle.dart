import 'dart:math';

import 'package:puzzlehack/models/puzzle_grid_position.dart';
import 'package:puzzlehack/models/tile.dart';

class SlidingTilesPuzzle {
  final int dimension;
  final List<PuzzleTile> tiles;
  final PuzzleGridPosition emptySpace;

  const SlidingTilesPuzzle(this.dimension, this.tiles, this.emptySpace);

  factory SlidingTilesPuzzle.solved(
    final int dimension,
  ) {
    final List<PuzzleTile> tiles = List.generate(
      (dimension * dimension) - 1,
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
        PuzzleGridPosition(dimension - 1, dimension - 1);

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
    final int numberOfIterations = dimension * 100;
    final randomizer = Random();

    for (var itr = 0; itr < numberOfIterations; itr++) {
      final int randomIndex = randomizer.nextInt((dimension * dimension) - 1);
      final candidate = mutablePuzzle.tiles.elementAt(randomIndex);
      if (mutablePuzzle.canMoveTile(candidate)) {
        mutablePuzzle = mutablePuzzle.moveTile(candidate);
      }
    }

    return mutablePuzzle;
  }

  bool get isSolved => tiles.every((t) => t.isInCorrectPosition);

  bool canMoveTile(PuzzleTile tile) {
    final bool adjacentColumns =
        (tile.currentPosition.x - emptySpace.x).abs() == 1;

    final bool sameRow = tile.currentPosition.y == emptySpace.y;

    final bool adjacentRows =
        (tile.currentPosition.y - emptySpace.y).abs() == 1;

    final bool sameColumn = tile.currentPosition.x == emptySpace.x;

    return (adjacentColumns && sameRow) || (adjacentRows && sameColumn);
  }

  SlidingTilesPuzzle moveTile(PuzzleTile tile) {
    final PuzzleGridPosition nextEmptySpace = tile.currentPosition;
    final movedTile = tile.copyWith(currentPosition: emptySpace);
    final mutableTiles = tiles;

    final int index = tiles.indexOf(tile);
    mutableTiles[index] = movedTile;

    return copyWith(
      tiles: mutableTiles,
      emptySpace: nextEmptySpace,
    );
  }
}

extension SlidingTilesPuzzleViewX on SlidingTilesPuzzle {}
