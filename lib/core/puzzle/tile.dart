import 'package:puzzlehack/core/puzzle/puzzle_grid_position.dart';

class PuzzleTile {
  final PuzzleGridPosition currentPosition;
  final PuzzleGridPosition expectedPosition;

  PuzzleTile(this.currentPosition, this.expectedPosition);

  PuzzleTile copyWith({
    PuzzleGridPosition? currentPosition,
    PuzzleGridPosition? expectedPosition,
  }) {
    return PuzzleTile(
      currentPosition ?? this.currentPosition,
      expectedPosition ?? this.expectedPosition,
    );
  }
}

extension TileX on PuzzleTile {
  bool get isInCorrectPosition => currentPosition == expectedPosition;
}
