import 'package:flutter/material.dart';

extension ColorParsing on String? {
  Color parseToColor() {
    int hexColor = int.parse('ff$this', radix: 16);
    return Color(hexColor);
  }
}
