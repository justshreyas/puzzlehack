import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_data_delegate.dart';
import 'package:puzzlehack/cubit/audio_manager/audio_manager_cubit.dart';
import 'package:puzzlehack/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Puzzle Hack : by justshreyas',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.orange,
          shape: StadiumBorder(),
        ),
        textTheme: TextTheme(
          headline3: GoogleFonts.workSans(
            fontSize: 36,
            color: Colors.black87,
          ),
          headline4: GoogleFonts.exo(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: Colors.white70,
          ),
          headline6: GoogleFonts.workSans(
            fontSize: 24,
            color: Colors.black87,
          ),
          button: GoogleFonts.exo(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white70,
          ),
        ),
      ),
      home: BlocProvider(
        create: (context) => AudioManagerCubit(AudioDataDelegate()),
        child: const WelcomeScreen(),
      ),
    );
  }
}
