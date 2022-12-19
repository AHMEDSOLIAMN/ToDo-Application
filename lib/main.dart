import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes/constant/themes.dart';
import 'package:notes/screens/note_details.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Themes.darkTheme,
      routes: {
        'HomeScreen': (context)=>HomeScreen(),
      },
      home:  HomeScreen(),
    );
  }
}

class Themes{
  static ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: HexColor('f4effa'),
    cardTheme:CardTheme(
        color: HexColor('422680'),
        elevation: 10
    ) ,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: HexColor('2f4550'),
      ),
      titleTextStyle: TextStyle(
        color: HexColor('1b263b'),
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      color: HexColor('f4effa'),
      elevation: 0,
    ),
  );
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: HexColor('141b28'),
    cardTheme: CardTheme(
        color: HexColor('1b263b')
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: HexColor('b0cbff'),
      ),
      titleTextStyle: TextStyle(
        color: HexColor('b0cbff'),
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      color: Colors.transparent,
      elevation: 0,
    ),
  );
}