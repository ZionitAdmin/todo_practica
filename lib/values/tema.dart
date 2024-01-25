import 'package:flutter/material.dart';

const Color primary = Color(0xff272838A8);
const Color secundary = Color(0xffC1BCBC);
const Color blanco = Color(0xffFFFFFF);
const Color rojo = Color(0xffE71616);
const Color amarillo = Color(0xffF5D02C);

ThemeData miTema(BuildContext con ){
  return ThemeData(
    primaryColor: primary , 
    colorScheme:ColorScheme.fromSwatch(
      primarySwatch:  Colors.grey,
    ).copyWith(
      secondary: Colors.blue,
    ),
  );
}