library globals;

import 'dart:math';

import 'package:flutter/cupertino.dart';

String currentPage = '';
double volumeValue = 50.0;

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double screenDiagonal;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double blockSizeDiagonal;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    screenDiagonal = sqrt(pow(screenWidth, 2) + pow(screenHeight, 2));
    blockSizeDiagonal = screenDiagonal / 100;
  }
}
