import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/screens/select_puzzle_variant_screen.dart';
import 'package:puzzlehack/widgets/puzzle_app_bar.dart';
import 'package:puzzlehack/widgets/puzzle_button.dart';
import 'package:puzzlehack/widgets/utils/animation_constants.dart';
import 'package:puzzlehack/widgets/utils/text_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioManagerCubit audioManagerCubit = context.watch();
    return Scaffold(
      appBar: PuzzleAppBar(
        audioManagerCubit: audioManagerCubit,
        showActions: false,showBackButton: false,
      ),
      backgroundColor: Colors.orange[50],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: AnimationConstants.longDuration,
                style: context.sizeAwareTextTheme.headline2!,
                child: const Text(
                  "Flutter Puzzle Hack",
                  textAlign: TextAlign.center,
                ),
              ),
                          const SizedBox(height: 5),

              AnimatedDefaultTextStyle(
                duration: AnimationConstants.longDuration,
                style: context.sizeAwareTextTheme.subtitle2!,
                child: const Text(
                  "a submission\nby justshreyas",
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              PuzzleButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: const RouteSettings(
                          name: "/SelectPuzzleVariantScreen"),
                      builder: (context) => SelectPuzzleVariantScreen(
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
    );
  }
}
