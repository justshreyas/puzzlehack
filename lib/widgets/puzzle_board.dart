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
    return BlocBuilder<GameSessionCubit, GameSessionState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is GameSessionEnded) {
          return  const Text("Wohoo!");
        }

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
