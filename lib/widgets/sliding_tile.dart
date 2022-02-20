import 'package:flutter/material.dart';
import 'package:puzzlehack/view_models/puzzle_tile_view_model.dart';

class SlidingTile extends StatelessWidget {
  final PuzzleTileViewModel puzzleTile;

  const SlidingTile({
    Key? key,
    required this.puzzleTile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 600),
      top: puzzleTile.distanceFromTop,
      left: puzzleTile.distanceFromLeft,
      child: SimplePuzzleTile(
        text: puzzleTile.tileDisplayData,
        size: puzzleTile.size,
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
    return Container(
      color: Colors.blue[300],
      child: SizedBox.fromSize(
        size: size,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
