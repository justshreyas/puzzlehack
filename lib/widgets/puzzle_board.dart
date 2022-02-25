import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlehack/core/puzzle_logic/cubit/game_session_cubit.dart';
import 'package:puzzlehack/view_models/puzzle_view_model.dart';
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
        return Container(
          color: Colors.grey[300],
          child: Stack(
            children: List.generate(
              state.model.puzzle.tiles.length,
              (index) {
                final tile = state.model.puzzle.tiles[index];
                final tileModel = state.model.tileViewModelFrom(tile);
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
        );
      },
    );
  }
}
