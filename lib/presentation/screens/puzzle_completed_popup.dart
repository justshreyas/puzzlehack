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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedDefaultTextStyle(
            duration: AnimationConstants.shortDuration,
            style: context.sizeAwareTextTheme.subtitle2!,
            child: const Text(
                "You made it! You solved the sliding tiles puzzle in"),
          ),
          AnimatedDefaultTextStyle(
            duration: AnimationConstants.shortDuration,
            style: context.sizeAwareTextTheme.subtitle2!
                .copyWith(color: Colors.orange[600]),
            child: Text("$puzzleCompletionTime, "),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedDefaultTextStyle(
                duration: AnimationConstants.shortDuration,
                style: context.sizeAwareTextTheme.subtitle2!,
                child: const Text(
                  "using a total of ",
                ),
              ),
              AnimatedDefaultTextStyle(
                duration: AnimationConstants.shortDuration,
                style: context.sizeAwareTextTheme.subtitle2!
                    .copyWith(color: Colors.orange),
                child: Text(
                  totalMoves,
                ),
              ),
              AnimatedDefaultTextStyle(
                duration: AnimationConstants.shortDuration,
                style: context.sizeAwareTextTheme.subtitle2!,
                child: const Text(
                  " moves.",
                ),
              ),
            ],
          ),
        ],
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
