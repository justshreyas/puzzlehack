import 'package:flutter/material.dart';
import 'package:puzzlehack/core/puzzle/puzzle_difficulty.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/widgets/puzzle_app_bar.dart';
import 'package:puzzlehack/widgets/puzzle_selection_card.dart';
import 'package:puzzlehack/widgets/utils/text_theme.dart';
import 'package:puzzlehack/widgets/utils/display_size.dart';

class SelectPuzzleVariantScreen extends StatefulWidget {
  final AudioManagerCubit audioManagerCubit;

  const SelectPuzzleVariantScreen({
    Key? key,
    required this.audioManagerCubit,
  }) : super(key: key);

  @override
  State<SelectPuzzleVariantScreen> createState() =>
      _SelectPuzzleVariantScreenState();
}

class _SelectPuzzleVariantScreenState extends State<SelectPuzzleVariantScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.audioManagerCubit.state.musicEnabled) {
      widget.audioManagerCubit.audioDataDelegate.playPreGameMusic();
    }
  }

  @override
  void dispose() {
    widget.audioManagerCubit.audioDataDelegate.pausePreGameMusic();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final windowSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PuzzleAppBar(
        audioManagerCubit: widget.audioManagerCubit,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 150),
                style: context.sizeAwareTextTheme.headline1!,
                child: const Text(
                  "Select a difficulty level",
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0).add(
                      const EdgeInsets.symmetric(
                          horizontal: 50)), //TODO adjustments
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            PuzzleDifficulty.values.length,
                            (index) => Expanded(
                              child: PuzzleSelectionCard(
                                audioManagerCubit: widget.audioManagerCubit,
                                difficulty: PuzzleDifficulty.values[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
