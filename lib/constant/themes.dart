
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme(){
  return ThemeData(
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
}
ThemeData darkTheme(){
  return ThemeData(
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
 bool iconBool = false;
IconData iconLight = Icons.light_mode;
IconData iconDark = Icons.dark_mode;
void changeIconTheme (){
  iconBool = !iconBool;
}