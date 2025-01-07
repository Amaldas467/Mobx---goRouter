import 'package:flutter/material.dart';

class ColorConstants {
  static Color textcolor = Colors.black;

  // Static Linear Gradient for background
  static LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.045, 0.496],
    colors: [
      Color(0xFFD4C8BC), // #D4C8BC
      Color(0xFFECEADE), // #ECEADE
    ],
  );

  //button color
  static Color buttonColor = Color.fromRGBO(162, 170, 123, 1);

  static Color buttonborder = Color.fromARGB(255, 228, 228, 228);

  static Color homecategorybutton = Color.fromARGB(194, 140, 126, 1);
}
