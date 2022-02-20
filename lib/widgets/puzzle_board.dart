import 'package:flutter/material.dart';
import 'package:puzzlehack/view_models/puzzle_view_model.dart';
import 'package:puzzlehack/widgets/sliding_tile.dart';

class PuzzleBoard extends StatelessWidget {
  final PuzzleViewModel viewModel;
  final Size tileSize;
  const PuzzleBoard({
    Key? key,
    required this.viewModel,
    required this.tileSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Stack(
        children: List.generate(
          viewModel.puzzle.tiles.length,
          (index) {
            final tileModel =
                viewModel.tileViewModelFrom(viewModel.puzzle.tiles[index]);
            //TODO : Figure out a better way to do this
            return SlidingTile(
              puzzleTile: tileModel,
            );
          },
        ),
      ),
    );
  }
}
