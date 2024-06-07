import 'package:flutter/material.dart';

/// A class that defines common colors used in different application themes.
abstract class CommonColors {
  final Color accent;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color dividerColor;
  final Color white;
  final Color black;
  final Color transparent;
  final Color success;
  final Color error;

  const CommonColors({
    required this.accent,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.dividerColor,
    required this.white,
    required this.black,
    required this.transparent,
    required this.success,
    required this.error,
  });
}
