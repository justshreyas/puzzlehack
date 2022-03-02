enum PuzzleDifficulty {
  easy,
  medium,
  hard,
}

extension PuzzleDifficultyX on PuzzleDifficulty {
  int get numberOfScrambles => this == PuzzleDifficulty.easy
      ? 50
      : this == PuzzleDifficulty.medium
          ? 80
          : 100;

  int get puzzleDimension => this == PuzzleDifficulty.easy
      ? 3
      : this == PuzzleDifficulty.medium
          ? 4
          : 5;

  bool get randomizeAtStart => this != PuzzleDifficulty.easy;
}
