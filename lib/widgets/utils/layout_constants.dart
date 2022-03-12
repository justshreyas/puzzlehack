import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:puzzlehack/widgets/utils/display_size.dart';

class LayoutConstants {
  static const Size buttonSizeSmall = Size(80, 40);
  static const Size buttonSizeMedium = Size(160, 80);
  static const Size buttonSizeLarge = Size(240, 120);

  static const EdgeInsets componentOnHoverPaddingSmall = EdgeInsets.all(5);
  static const EdgeInsets componentOnHoverPaddingMedium = EdgeInsets.all(10);
  static const EdgeInsets componentOnHoverPaddingLarge = EdgeInsets.all(20);

  static const EdgeInsets bodyPaddingSmall = EdgeInsets.all(20);
  static const EdgeInsets bodyPaddingMedium = EdgeInsets.all(50);
  static const EdgeInsets bodyPaddingLarge = EdgeInsets.all(80);

  static const double onHoverMultiplier = 1.12;

  static const Size spacerSmall = Size(10, 10);
  static const Size spacerMedium = Size(20, 20);
  static const Size spacerLarge = Size(50, 50);

  static Size spacer(DisplaySize displaySize) {
    if (displaySize == DisplaySize.large) {
      return spacerLarge;
    }
    if (displaySize == DisplaySize.medium) {
      return spacerMedium;
    } else {
      return spacerSmall;
    }
  }

  static Size buttonSize(DisplaySize displaySize) {
    if (displaySize == DisplaySize.large) {
      return buttonSizeLarge;
    }
    if (displaySize == DisplaySize.medium) {
      return buttonSizeMedium;
    } else {
      return buttonSizeSmall;
    }
  }

  static EdgeInsets componentOnHoverPadding(DisplaySize displaySize) {
    if (displaySize == DisplaySize.large) {
      return componentOnHoverPaddingLarge;
    }
    if (displaySize == DisplaySize.medium) {
      return componentOnHoverPaddingMedium;
    } else {
      return componentOnHoverPaddingSmall;
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
}
