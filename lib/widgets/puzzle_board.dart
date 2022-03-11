import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlehack/core/puzzle/tile.dart';
import 'package:puzzlehack/core/puzzle_logic/cubit/game_session_cubit.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/view_models/puzzle_tile_view_model.dart';
import 'package:puzzlehack/widgets/sliding_tile.dart';

class PuzzleBoard extends StatelessWidget {
  final GameSessionCubit cubit;
  final AudioManagerCubit audioManagerCubit;
  const PuzzleBoard({
    Key? key,
    required this.cubit,
    required this.audioManagerCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameSessionCubit, GameSessionState>(
      bloc: cubit,
      builder: (context, state) {
        final size = MediaQuery.of(context).size;
        final availableSize =
            Size(size.width, size.height - 100); // Compensate for appbar height

        final availableExpanse = (min(
              availableSize.longestSide / 2,
              availableSize.shortestSide,
            )) -
            60; // Compensate for various paddings

        final double tileSide =
            (availableExpanse / state.puzzle.dimension).truncateToDouble();

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
                        final moved = cubit.handleTileTapped(tile);
                        if (moved && audioManagerCubit.state.soundsEnabled) {
                          audioManagerCubit.audioDataDelegate
                              .playTileMovementSound();
                        }
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
