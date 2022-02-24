import 'package:flutter/material.dart';
import 'package:puzzlehack/view_models/puzzle_tile_view_model.dart';

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
          color: Theme.of(context).primaryColor.withOpacity(0.6),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
      ),
    );
  }
}
