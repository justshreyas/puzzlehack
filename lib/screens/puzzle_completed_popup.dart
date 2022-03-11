import 'package:flutter/material.dart';
import 'package:puzzlehack/widgets/puzzle_button.dart';
import 'package:puzzlehack/widgets/utils/animation_constants.dart';
import 'package:puzzlehack/widgets/utils/text_theme.dart';

class PuzzleCompletedPopup extends StatelessWidget {
  const PuzzleCompletedPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
    
      title: AnimatedDefaultTextStyle(
        duration: AnimationConstants.longDuration,
        style: context.sizeAwareTextTheme.headline3!,
        child: const Text(
          "Wohoo!",
        ),
      ),
      content: AnimatedDefaultTextStyle(
        duration: AnimationConstants.longDuration,
        style: context.sizeAwareTextTheme.subtitle2!,
        child: const Text(
          "You made it! You solved the puzzle in XX m YY s\n, using ZZ moves.", // TODO : Add
        ),
      ),
      actions: [
        PuzzleButton(
          text: "GO BACK",
          onPressed: () {
            Navigator.popUntil(
              context,
              (route) => route.settings.name == "/SelectPuzzleVariantScreen",
            );
          },
        ),
      ],
    );
  }
}
