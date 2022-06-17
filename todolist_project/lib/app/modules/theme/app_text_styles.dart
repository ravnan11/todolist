import 'package:flutter/material.dart';

abstract class AppTextStyle {
  TextStyle get inputWhite;
  TextStyle get inputBlack;
  TextStyle get hint;
}

class AppTextStyleImp implements AppTextStyle {
  @override
  TextStyle get inputWhite => TextStyle(
        color: Colors.white,
        fontSize: 16,
      );

  @override
  TextStyle get inputBlack => TextStyle(
        color: Colors.black,
        fontSize: 14,
      );

  @override
  TextStyle get hint => TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w200,
      );
}
