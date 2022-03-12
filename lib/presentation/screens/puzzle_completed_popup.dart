import 'package:flutter/material.dart';
import 'package:puzzlehack/presentation/utils/animation_constants.dart';
import 'package:puzzlehack/presentation/utils/display_size.dart';
import 'package:puzzlehack/presentation/utils/text_theme.dart';
import 'package:puzzlehack/presentation/widgets/buttons/puzzle_button.dart';

class PuzzleCompletedPopup extends StatelessWidget {
  final String puzzleCompletionTime, totalMoves;

  const PuzzleCompletedPopup({
    Key? key,
    required this.puzzleCompletionTime,
    required this.totalMoves,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: AnimatedDefaultTextStyle(
        duration: AnimationConstants.shortDuration,
        style: context.sizeAwareTextTheme.headline3!,
        child: const Text(
          "Wohoo!",
        ),
      ),
      content: AnimatedDefaultTextStyle(
        duration: AnimationConstants.shortDuration,
        style: context.sizeAwareTextTheme.subtitle2!,
        child: Text(
          "You made it! You solved the sliding tiles puzzle in "
          "\n$puzzleCompletionTime, "
          "\nusing a total of $totalMoves moves.", 
        ),
      ),
      actions: [
        PuzzleButton(
          displaySize: MediaQuery.of(context).size.displaySize,
          text: "GO BACK",
          onPressed: () {
            Navigator.popUntil(
              context,
              (route) => route.settings.name == "/SelectDifficulty",
            );
          },
        ),
      ],
    );
  }
}
