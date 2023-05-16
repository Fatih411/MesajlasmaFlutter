import 'package:flutter/material.dart';

class Contants {
  static TextStyle titletTextStyle() {
    return const TextStyle(
        color: Colors.black, fontSize: 24.5, fontWeight: FontWeight.bold);
  }

  static Color titleColor(int index) {
    return index % 2 == 0 ? Colors.grey : Colors.indigo.shade600;
  }

  static TextStyle containertTextStyle() {
    return const TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
  }
}
