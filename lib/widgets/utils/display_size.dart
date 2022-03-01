import 'package:flutter/material.dart';

enum DisplaySize {
  small,
  medium,
  large,
}

extension DisplaySizeUtil on Size {
  bool get isLarge => shortestSide > 650;
  bool get isMedium => shortestSide > 350 && shortestSide < 660;
  bool get isSmall => shortestSide < 350;

  DisplaySize get displaySize {
    return isLarge
        ? DisplaySize.large
        : isSmall
            ? DisplaySize.small
            : DisplaySize.medium;
  }
}
