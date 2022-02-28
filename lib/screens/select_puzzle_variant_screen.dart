import 'package:flutter/material.dart';
import 'package:puzzlehack/core/puzzle/puzzle_difficulty.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/widgets/puzzle_app_bar.dart';
import 'package:puzzlehack/widgets/puzzle_selection_card.dart';

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
    return Scaffold(
      appBar: PuzzleAppBar(
        audioManagerCubit: widget.audioManagerCubit,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "Select a difficulty level",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(30.0).add(
                    const EdgeInsets.symmetric(
                        horizontal: 150)), //TODO adjustments
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final bool isLandscape =
                        constraints.maxWidth > constraints.maxHeight;
                    final List<Widget> selectionCards = List.generate(
                      PuzzleDifficulty.values.length,
                      (index) => Expanded(
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: 2,
                            child: PuzzleSelectionCard(
                              audioManagerCubit: widget.audioManagerCubit,
                              difficulty: PuzzleDifficulty.values[index],
                            ),
                          ),
                        ),
                      ),
                    );
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 50),
                      transitionBuilder: (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                      child: isLandscape
                          ? Row(
                              children: selectionCards,
                            )
                          : Column(
                              children: selectionCards,
                            ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
