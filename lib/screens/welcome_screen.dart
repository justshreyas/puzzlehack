import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/screens/select_puzzle_variant_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioManagerCubit audioManagerCubit = context.watch();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Flutter Puzzle Hack",
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              "a submission by justshreyas",
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 20),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                "PLAY",
                style: Theme.of(context).textTheme.button,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    settings:
                        const RouteSettings(name: "/SelectPuzzleVariantScreen"),
                    builder: (context) => SelectPuzzleVariantScreen(
                      audioManagerCubit: audioManagerCubit,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
