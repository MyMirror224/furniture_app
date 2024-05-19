import 'package:flutter/material.dart';

class AppTheme {
  // Private Constructor

  AppTheme._();
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white, // background app
      appBarTheme: const AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xff93B1A6), // chinh mau cua icon appbar
          ),
          titleTextStyle: TextStyle(
            color: Colors.black, // chinh mau cua title appbar
          )),
      textTheme: const TextTheme(
        // chinh mau cua text trong app
        bodyLarge: TextStyle(
          color: Color(0xff193d3d),
        ),
        bodyMedium: TextStyle(
          color: Colors.black,
        ),
        bodySmall: TextStyle(
          color: Colors.black,
        ),
      ),
      //màu elevation button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xff193d3d)),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Color(0xff193d3d), // chinh mau cua button
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xff93b1a7)),
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),

        // colorScheme: ColorScheme
        // colorScheme: const ColorScheme(
        //   background: Colors.white,
        //   brightness: Brightness.light,
        //   primary: Color(0xff193d3d),
        //   onPrimary: Colors.white,
        //   secondary: Colors.black,
        //   onSecondary: Colors.white,
        //   error: Colors.red,
        //   onError: Colors.white,
        //   onBackground: Colors.black,
        //   surface: Colors.white,
        //   onSurface: Colors.black,
        // ),
      ));

  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black, // background app
      appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 17, 26, 22),
          iconTheme: IconThemeData(
            color: Color(0xff93B1A6), // chinh mau cua icon appbar
          ),
          titleTextStyle: TextStyle(
            color: Colors.white, // chinh mau cua title appbar
          )),
      textTheme: const TextTheme(
        // chinh mau cua text trong app
        bodyLarge: TextStyle(
          color: Color.fromARGB(255, 244, 251, 251),
        ),
        bodyMedium: TextStyle(
          color: Colors.white,
        ),
        bodySmall: TextStyle(
          color: Colors.white,
        ),
      ),
      //màu elevation button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xff193d3d)),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Color(0xff193d3d), // chinh mau cua button
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xff93b1a7)),
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),

        // colorScheme: ColorScheme
        // colorScheme: const ColorScheme(
        //   background: Colors.white,
        //   brightness: Brightness.light,
        //   primary: Color(0xff193d3d),
        //   onPrimary: Colors.white,
        //   secondary: Colors.black,
        //   onSecondary: Colors.white,
        //   error: Colors.red,
        //   onError: Colors.white,
        //   onBackground: Colors.black,
        //   surface: Colors.white,
        //   onSurface: Colors.black,
        // ),
      ));
}
