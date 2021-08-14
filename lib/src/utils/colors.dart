import 'package:flutter/material.dart';

class TestColor {
  static const CelesteLight = "#78b3e0";
  static const CelesteDark = "#015ca2";
  static const BoxWhite = "#FFFFFF";
  
  static Color fromHex(String hexString) {
    print(hexString);
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

