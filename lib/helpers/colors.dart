import 'package:flutter/material.dart';
// coverage:ignore-file

class AppColors {
  AppColors._();

  static Color baseColorLight = Colors.yellow.shade500;
  static Color baseColorDark = Colors.brown;
  static Color transparentColor = Colors.transparent;
  static Color brown = const Color(0xff4B4B4B);

  /// color for toggles
  final MaterialStateProperty<Color?> trackColor =
      MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      // Track color when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return Colors.amber;
      }
      // Otherwise return null to set default track color
      // for remaining states such as when the switch is
      // hovered, focused, or disabled.
      return Colors.grey;
    },
  );
}
