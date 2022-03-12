import 'package:flutter/material.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/widgets/puzzle_app_bar.dart';
import 'package:puzzlehack/widgets/puzzle_selection_options.dart';
import 'package:puzzlehack/widgets/utils/animation_constants.dart';
import 'package:puzzlehack/widgets/utils/display_size.dart';
import 'package:puzzlehack/widgets/utils/layout_constants.dart';
import 'package:puzzlehack/widgets/utils/text_theme.dart';

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
    final displaySize = MediaQuery.of(context).size.displaySize;
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: PuzzleAppBar(
        audioManagerCubit: widget.audioManagerCubit,
      ),
      body: Padding(
        padding: LayoutConstants.bodyPadding(displaySize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedDefaultTextStyle(
              duration: AnimationConstants.longDuration,
              style: context.sizeAwareTextTheme.headline4!,
              child: const Text(
                "Select a difficulty level",
              ),
            ),
            const SizedBox(height: 50, width: 50),
            Expanded(
              child: Center(
                child: PuzzleSelectionOptions(
                  audioManagerCubit: widget.audioManagerCubit,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
