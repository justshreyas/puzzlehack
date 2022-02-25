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
        textTheme: 
        TextTheme(
  headline1: GoogleFonts.workSans(
    fontSize: 102,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5
  ),
  headline2: GoogleFonts.workSans(
    fontSize: 64,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5
  ),
  headline3: GoogleFonts.workSans(
    fontSize: 51,
    fontWeight: FontWeight.w400
  ),
  headline4: GoogleFonts.workSans(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25
  ),
  headline5: GoogleFonts.workSans(
    fontSize: 25,
    fontWeight: FontWeight.w400
  ),
  headline6: GoogleFonts.workSans(
    fontSize: 21,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15
  ),
  subtitle1: GoogleFonts.workSans(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15
  ),
  subtitle2: GoogleFonts.workSans(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1
  ),
  bodyText1: GoogleFonts.exo(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5
  ),
  bodyText2: GoogleFonts.exo(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25
  ),
  button: GoogleFonts.exo(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25
  ),
  caption: GoogleFonts.exo(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4
  ),
  overline: GoogleFonts.exo(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5
  ),
),
        // TextTheme(
        //   headline3: GoogleFonts.workSans(
        //     fontSize: 36,
        //     color: Colors.black87,
        //   ),
        //   headline4: GoogleFonts.exo(
        //     fontSize: 36,
        //     fontWeight: FontWeight.w700,
        //     color: Colors.white70,
        //   ),
        //   headline6: GoogleFonts.workSans(
        //     fontSize: 24,
        //     color: Colors.black87,
        //   ),
        //   button: GoogleFonts.exo(
        //     fontSize: 18,
        //     fontWeight: FontWeight.w700,
        //     color: Colors.white70,
        //   ),
        // ),
      ),
      home: BlocProvider(
        create: (context) => AudioManagerCubit(AudioDataDelegate()),
        child: const WelcomeScreen(),
      ),
    );
  }
}
