import 'package:flutter/material.dart' show TextStyle, FontWeight, Color;

import '../../theme/text_hierarchy/text_hierarchy.dart';

class T2TextHierarchy implements TextHierarchy {
  @override
  TextStyle get body1 => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFF212121),
      );

  @override
  TextStyle get body2 => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF212121),
      );

  @override
  TextStyle get button => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFFFFFFFF),
      );

  @override
  TextStyle get caption => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF757575),
      );

  @override
  TextStyle get h1 => const TextStyle(
        fontSize: 96,
        fontWeight: FontWeight.w300,
        color: Color(0xFF795548),
      );

  @override
  TextStyle get h2 => const TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w300,
        color: Color(0xFF795548),
      );

  @override
  TextStyle get h3 => const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.normal,
        color: Color(0xFF795548),
      );

  @override
  TextStyle get h4 => const TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.normal,
        color: Color(0xFF795548),
      );

  @override
  TextStyle get h5 => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.normal,
        color: Color(0xFF795548),
      );

  @override
  TextStyle get h6 => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF795548),
      );

  @override
  TextStyle get overline => const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        color: Color(0xFF757575),
      );

  @override
  TextStyle get subtitle1 => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFF212121),
      );

  @override
  TextStyle get subtitle2 => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF212121),
      );
}
