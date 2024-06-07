import 'package:flutter/material.dart' show TextStyle;

/// A class that represents the hierarchy of text styles.
interface class TextHierarchy {
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle h4;
  final TextStyle h5;
  final TextStyle h6;
  final TextStyle subtitle1;
  final TextStyle subtitle2;
  final TextStyle body1;
  final TextStyle body2;
  final TextStyle button;
  final TextStyle caption;
  final TextStyle overline;

  const TextHierarchy({
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
    required this.h6,
    required this.subtitle1,
    required this.subtitle2,
    required this.body1,
    required this.body2,
    required this.button,
    required this.caption,
    required this.overline,
  });
}
