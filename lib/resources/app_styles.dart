import 'package:flutter/material.dart';

class AppStyles {
  static TextStyle titleX({double size = 64, Color color = Colors.black}) {
    return TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold);
  }

  static TextStyle title1({double size = 32, Color color = Colors.black}) {
    return TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold);
  }

  static TextStyle title3({double size = 18, Color color = Colors.black}) {
    return TextStyle(color: color, fontSize: size, fontWeight: FontWeight.w600);
  }

  static TextStyle regular1(
      {double size = 16,
      Color color = Colors.black,
      FontWeight weight = FontWeight.normal}) {
    return TextStyle(color: color, fontSize: size, fontWeight: weight);
  }

  static TextStyle medium({double size = 16, Color color = Colors.black}) {
    return TextStyle(color: color, fontSize: size, fontWeight: FontWeight.w500);
  }

  static TextStyle bold({double size = 16, Color color = Colors.black}) {
    return TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold);
  }

  static TextStyle appTitle({double size = 18, Color color = Colors.black}) {
    return TextStyle(color: color, fontSize: size, fontWeight: FontWeight.w600);
  }

  static TextStyle snackBar({double size = 18, Color color = Colors.white}) =>
      medium(size: size, color: color);
}
