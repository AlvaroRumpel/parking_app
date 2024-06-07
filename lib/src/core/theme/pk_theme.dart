import 'dart:developer';

import 'package:flutter/material.dart';

import '../theme_implementation/theme1/t1_implementation.dart';
import '../theme_implementation/theme2/t2_implementation.dart';
import 'colors/custom_colors.dart';
import 'sizes/custom_radius.dart';
import 'sizes/spacing.dart';
import 'text_hierarchy/text_hierarchy.dart';

enum Flavor {
  t1('t1'),
  t2('t2');

  final String value;

  const Flavor(this.value);

  static Flavor fromString(String theme) {
    return switch (theme) {
      't1' => Flavor.t1,
      't2' => Flavor.t2,
      _ => throw FormatException('Tema inválido: $theme')
    };
  }

  T fromFlavor<T>(T t1, T t2) {
    return switch (this) {
      Flavor.t1 => t1,
      Flavor.t2 => t2,
    };
  }
}

class PKTheme {
  late final CustomColors colors;
  late final CustomRadius radius;
  late final TextHierarchy textHierarchy;
  late final Spacing spacing;
  late final Flavor _flavor;

  static final PKTheme _instance = PKTheme._internal();

  static PKTheme get i => _instance;

  PKTheme._internal();

  static void initialize(String flavorName) {
    log('Inicializando o PKTheme com o flavor: $flavorName');
    i._flavor = Flavor.fromString(flavorName);
    _initColors(i._flavor);
    _initRadius(i._flavor);
    _initSpacing(i._flavor);
    _initTextHierarchy(i._flavor);
  }

  static void _initColors(Flavor flavor) {
    PKTheme.i.colors = flavor.fromFlavor(T1Colors(), T2Colors());
  }

  static void _initRadius(Flavor flavor) {
    PKTheme.i.radius = flavor.fromFlavor(T1BorderRadius(), T2BorderRadius());
  }

  static void _initSpacing(Flavor flavor) {
    PKTheme.i.spacing = flavor.fromFlavor(T1Spacing(), T2Spacing());
  }

  static void _initTextHierarchy(Flavor flavor) {
    PKTheme.i.textHierarchy = flavor.fromFlavor(
      T1TextHierarchy(),
      T2TextHierarchy(),
    );
  }

  ThemeData buildThemeData() {
    return ThemeData(
      colorScheme: ColorScheme(
        primary: colors.primary,
        secondary: colors.secondary,
        surface: colors.white,
        error: colors.error,
        onPrimary: colors.primaryTextColor,
        onSecondary: colors.secondaryTextColor,
        onSurface: colors.black,
        onError: colors.white,
        brightness: Brightness.light,
      ),
      textTheme: TextTheme(
        displayLarge: textHierarchy.h1,
        displayMedium: textHierarchy.h2,
        displaySmall: textHierarchy.h3,
        headlineMedium: textHierarchy.h4,
        headlineSmall: textHierarchy.h5,
        titleLarge: textHierarchy.h6,
        titleMedium: textHierarchy.subtitle1,
        titleSmall: textHierarchy.subtitle2,
        bodyLarge: textHierarchy.body1,
        bodyMedium: textHierarchy.body2,
        labelLarge: textHierarchy.button,
        bodySmall: textHierarchy.caption,
        labelSmall: textHierarchy.overline,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary, // Background color
          foregroundColor: colors.primaryTextColor, // Text color
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius.medium),
        ),
      ),
    );
  }
}
