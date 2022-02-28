import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/screens/select_puzzle_variant_screen.dart';
import 'package:puzzlehack/widgets/puzzle_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioManagerCubit audioManagerCubit = context.watch();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Flutter Puzzle Hack",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                "a submission\nby justshreyas",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 20),
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
