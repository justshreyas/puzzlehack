import 'package:flutter/material.dart';
import 'package:puzzlehack/view_models/puzzle_tile_view_model.dart';
import 'package:puzzlehack/widgets/utils/text_theme.dart';

class SlidingTile extends StatelessWidget {
  final PuzzleTileViewModel puzzleTile;
  final int animationDurationInMilliseconds;
  final void Function() onTap;

  const SlidingTile({
    Key? key,
    required this.puzzleTile,
    required this.onTap,
    this.animationDurationInMilliseconds = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: animationDurationInMilliseconds),
      curve: Curves.decelerate,
      top: puzzleTile.distanceFromTop,
      left: puzzleTile.distanceFromLeft,
      child: GestureDetector(
        onTap: onTap,
        child: SimplePuzzleTile(
          text: puzzleTile.tileDisplayData,
          size: puzzleTile.size,
        ),
      ),
    );
  }
}

class SimplePuzzleTile extends StatelessWidget {
  final Size size;
  final String text;
  const SimplePuzzleTile({
    Key? key,
    required this.size,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: size,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Center(
            child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 150),
                style: context.sizeAwareTextTheme.subtitle1!,
              child: Text(
                text,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
