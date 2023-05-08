// provider or controller
import 'dart:math';
import 'package:flutter/material.dart';

class ColorController {
  static int _red = 255, _blue = 255, _green = 255; // equal to white
  static late Color currentColor;
  static Set<Color> colors = {};

  static init() {
    currentColor = Color.fromRGBO(_red, _green, _blue, 1);
  }

  static Color generateColor() {
    _red = Random().nextInt(256);
    _blue = Random().nextInt(256);
    _green = Random().nextInt(256);
    currentColor = Color.fromRGBO(_red, _green, _blue, 1);
    debugPrint('generate- $currentColor');
    if (!colors.contains(currentColor)) {
      colors.add(currentColor);// get new color code and add it to colors
    } else {
      generateColor();
    }

    return currentColor;
  }
}
