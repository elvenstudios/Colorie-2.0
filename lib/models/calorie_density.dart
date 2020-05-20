import 'package:colorie/theme/brand_colors.dart';
import 'package:flutter/widgets.dart';

abstract class CalorieDensity {
  double calculateDensity();

  // gets the color for the average of all entries in the log
  Color get color {
    final double density = calculateDensity();

    if (density <= 0.6) {
      return green;
    }

    if (density <= 1.5) {
      return yellow;
    }

    if (density <= 3.8) {
      return orange;
    }

    return red;
  }
}
