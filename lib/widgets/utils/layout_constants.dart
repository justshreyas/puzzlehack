import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:puzzlehack/widgets/utils/display_size.dart';

class LayoutConstants {
  static const Size appBarSizeSmall = Size.fromHeight(70);
  static const Size appBarSizeMedium = Size.fromHeight(80);
  static const Size appBarSizeLarge = Size.fromHeight(100);

  static const EdgeInsets outerComponentPaddingSmall = EdgeInsets.all(5);
  static const EdgeInsets outerComponentPaddingMedium = EdgeInsets.all(10);
  static const EdgeInsets outerComponentPaddingLarge = EdgeInsets.all(20);

  static const EdgeInsets bodyPaddingSmall = EdgeInsets.all(50);
  static const EdgeInsets bodyPaddingMedium = EdgeInsets.all(100);
  static const EdgeInsets bodyPaddingLarge = EdgeInsets.all(200);

  static const double onHoverMultiplier = 1.12;

  static const double iconSizeSmall = 15.0;
  static const double iconSizeMedium = 18.0;
  static const double iconSizeLarge = 24.0;

  static const double borderThicknessSmall = 2.0;
  static const double borderThicknessMedium = 4.0;
  static const double borderThicknessLarge = 6.0;

  static Size appBarSize(DisplaySize displaySize) {
    if (displaySize == DisplaySize.large) {
      return appBarSizeLarge;
    }
    if (displaySize == DisplaySize.medium) {
      return appBarSizeMedium;
    } else {
      return appBarSizeSmall;
    }
  }

  static EdgeInsets outerComponentPadding(DisplaySize displaySize) {
    if (displaySize == DisplaySize.large) {
      return outerComponentPaddingLarge;
    }
    if (displaySize == DisplaySize.medium) {
      return outerComponentPaddingMedium;
    } else {
      return outerComponentPaddingSmall;
    }
  }

  static EdgeInsets bodyPadding(DisplaySize displaySize) {
    if (displaySize == DisplaySize.large) {
      return bodyPaddingLarge;
    }
    if (displaySize == DisplaySize.medium) {
      return bodyPaddingMedium;
    } else {
      return bodyPaddingSmall;
    }
  }

  static double iconSize(DisplaySize displaySize) {
    if (displaySize == DisplaySize.large) {
      return iconSizeLarge;
    }
    if (displaySize == DisplaySize.medium) {
      return iconSizeMedium;
    } else {
      return iconSizeSmall;
    }
  }

  static double borderThickness(DisplaySize displaySize) {
    if (displaySize == DisplaySize.large) {
      return borderThicknessLarge;
    }
    if (displaySize == DisplaySize.medium) {
      return borderThicknessMedium;
    } else {
      return borderThicknessSmall;
    }
  }
}
