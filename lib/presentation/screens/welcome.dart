import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/presentation/screens/select_difficulty.dart';
import 'package:puzzlehack/presentation/utils/layout_constants.dart';
import 'package:puzzlehack/presentation/utils/animation_constants.dart';
import 'package:puzzlehack/presentation/utils/display_size.dart';
import 'package:puzzlehack/presentation/utils/text_theme.dart';
import 'package:puzzlehack/presentation/widgets/buttons/puzzle_button.dart';
import 'package:puzzlehack/presentation/widgets/puzzle_app_bar.dart';

class Welccome extends StatelessWidget {
  const Welccome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioManagerCubit audioManagerCubit = context.watch();
    final displaySize = MediaQuery.of(context).size.displaySize;
    return Scaffold(
      appBar: PuzzleAppBar(
        audioManagerCubit: audioManagerCubit,
        showActions: false,
        showBackButton: false,
      ),
      backgroundColor: Colors.orange[50],
      body: Container(
        constraints: const BoxConstraints(minHeight: 200),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedDefaultTextStyle(
                  duration: AnimationConstants.shortDuration,
                  style: context.sizeAwareTextTheme.headline2!,
                  child: const Text(
                    "Flutter Puzzle Hack",
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 5),
                AnimatedDefaultTextStyle(
                  duration: AnimationConstants.shortDuration,
                  style: context.sizeAwareTextTheme.subtitle2!,
                  child: const Text(
                    "a submission\nby justshreyas",
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox.fromSize(size: LayoutConstants.spacer(displaySize)),
                PuzzleButton(
                  displaySize: displaySize,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        settings:
                            const RouteSettings(name: "/SelectDifficulty"),
                        builder: (context) => SelectDifficulty(
                          audioManagerCubit: audioManagerCubit,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
