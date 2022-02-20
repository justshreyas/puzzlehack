import 'dart:ui';

import 'package:puzzlehack/core/puzzle/puzzle_grid_position.dart';

class PuzzleTileViewModel {
  final String id;
  PuzzleGridPosition position;
  final String tileDisplayData;

  final Size size;

  PuzzleTileViewModel(
    this.id,
    this.position,
    this.tileDisplayData,
    this.size,
  );

  double get distanceFromTop => position.y * size.height;

  double get distanceFromLeft => position.x * size.width;
}
