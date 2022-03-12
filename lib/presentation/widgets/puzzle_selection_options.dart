import 'package:flutter/material.dart';
import 'package:puzzlehack/models/puzzle_difficulty.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/presentation/utils/animation_constants.dart';
import 'package:puzzlehack/presentation/widgets/puzzle_selection_card.dart';

class PuzzleSelectionOptions extends StatelessWidget {
  final AudioManagerCubit audioManagerCubit;

  const PuzzleSelectionOptions({
    Key? key,
    required this.audioManagerCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final children = List.generate(
          PuzzleDifficulty.values.length,
          (index) => Expanded(
            child: PuzzleSelectionCard(
              audioManagerCubit: audioManagerCubit,
              difficulty: PuzzleDifficulty.values[index],
            ),
          ),
        );

        final biggestSize = constraints.biggest;

        final showRow = biggestSize.aspectRatio > 1.8;

        return AnimatedSwitcher(
          duration: AnimationConstants.shortestDuration,
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: showRow
              ? Row(
                  children: children,
                )
              : Column(
                  children: children,
                ),
        );
      },
    );
  }
}
