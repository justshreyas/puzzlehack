import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlehack/core/puzzle/tile.dart';
import 'package:puzzlehack/core/puzzle_logic/cubit/game_session_cubit.dart';
import 'package:puzzlehack/view_models/puzzle_tile_view_model.dart';
import 'package:puzzlehack/widgets/sliding_tile.dart';

class PuzzleBoard extends StatelessWidget {
  final GameSessionCubit cubit;
  const PuzzleBoard({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameSessionCubit, GameSessionState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is GameSessionEnded) {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(
                  "Wohoo!",
                  style: Theme.of(context).textTheme.headline3,
                ),
                content: Text(
                  "You made it! You solved the puzzle",
                  style: Theme.of(context).textTheme.headline6,
                ),
                actions: [
                  FloatingActionButton.extended(
                    label: Text(
                      "GO BACK",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    onPressed: () {
                      Navigator.popUntil(
                        context,
                        (route) =>
                            route.settings.name == "/SelectPuzzleVariantScreen",
                      );
                    },
                  )
                ],
              );
            },
            barrierDismissible: false,
          );
        }
      },
      builder: (context, state) {
        final availableSize = MediaQuery.of(context).size;

        final availableExpanse = (min(
              availableSize.longestSide / 2,
              availableSize.shortestSide,
            )) -
            100;

        final double tileSide = availableExpanse / state.puzzle.dimension;

        final puzzleBoardSize = Size(availableExpanse, availableExpanse);
        final tileSize = Size(tileSide, tileSide);

        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.grey[100],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox.fromSize(
              size: puzzleBoardSize,
              child: Stack(
                children: List.generate(
                  state.puzzle.tiles.length,
                  (index) {
                    final tile = state.puzzle.tiles[index];
                    final tileModel = tileViewModelFrom(tile, tileSize);
                    return SlidingTile(
                      puzzleTile: tileModel,
                      animationDurationInMilliseconds:
                          (state is GameSessionScrambling) ? 50 : 200,
                      onTap: () {
                        cubit.handleTileTapped(tile);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  PuzzleTileViewModel tileViewModelFrom(PuzzleTile tile, size) {
    return PuzzleTileViewModel(
      tile.id,
      tile.currentPosition,
      tile.id,
      size,
    );
  }
}
