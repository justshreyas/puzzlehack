import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puzzlehack/screens/home_page.dart';

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
      home: const MyHomePage(title: "Let's play!"),
    );
  }
}
