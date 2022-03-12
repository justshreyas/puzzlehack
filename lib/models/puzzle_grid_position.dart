class PuzzleGridPosition {
  final int x;
  final int y;

  PuzzleGridPosition(this.x, this.y);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PuzzleGridPosition && other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
