import 'package:puzzlehack/core/puzzle/puzzle_grid_position.dart';

class PuzzleTile {
  final String id;
  final PuzzleGridPosition currentPosition;
  final PuzzleGridPosition expectedPosition;

  PuzzleTile(this.id, this.currentPosition, this.expectedPosition);

  PuzzleTile copyWith({
    PuzzleGridPosition? currentPosition,
    PuzzleGridPosition? expectedPosition,
  }) {
    return PuzzleTile(
      id,
      currentPosition ?? this.currentPosition,
      expectedPosition ?? this.expectedPosition,
    );
  }
}

extension TileX on PuzzleTile {
  bool get isInCorrectPosition => currentPosition == expectedPosition;
}
