import 'package:flutter/material.dart';
import 'package:puzzlehack/presentation/utils/animation_constants.dart';
import 'package:puzzlehack/presentation/utils/display_size.dart';
import 'package:puzzlehack/presentation/utils/text_theme.dart';
import 'package:puzzlehack/presentation/widgets/buttons/puzzle_button.dart';

class PuzzleCompletedPopup extends StatelessWidget {
  const PuzzleCompletedPopup({Key? key}) : super(key: key);

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
        child: const Text(
          "You made it! You solved the puzzle in XX m YY s\n, using ZZ moves.", // TODO : Add
        ),
      ),
      actions: [
        PuzzleButton(
          displaySize: MediaQuery.of(context).size.displaySize,
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
