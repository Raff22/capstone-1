import 'package:flutter/material.dart';

extension ScreenExtension on BuildContext {
  double getWidth({double divide = 1}) {
    return MediaQuery.of(this).size.width / divide;
  }

  double getHeight({double divide = 1}) {
    return MediaQuery.of(this).size.height / divide;
  }
  double getWidthM({double multiply = 1}) {
    return MediaQuery.of(this).size.width * multiply;
  }

  double getHeightM({double multiply = 1}) {
    return MediaQuery.of(this).size.height * multiply;
  }
}
