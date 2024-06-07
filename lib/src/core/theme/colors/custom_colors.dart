import 'package:flutter/material.dart';

import 'common_colors.dart';

/// A class that defines custom colors for the application.
interface class CustomColors extends CommonColors {
  final Color primary;
  final Color primaryDark;
  final Color primaryLight;
  final Color secondary;
  final Color secondaryDark;
  final Color secondaryLight;

  /// Creates a new instance of [CustomColors].
  ///
  /// The [primary], [primaryDark], [primaryLight], [secondary],
  /// [secondaryDark], and [secondaryLight] are required parameters that
  /// define the custom colors for the application.
  ///
  /// The remaining parameters are inherited from the [CommonColors] class.
  const CustomColors({
    required this.primary,
    required this.primaryDark,
    required this.primaryLight,
    required this.secondary,
    required this.secondaryDark,
    required this.secondaryLight,
    required super.accent,
    required super.primaryTextColor,
    required super.secondaryTextColor,
    required super.dividerColor,
    required super.white,
    required super.black,
    required super.transparent,
    required super.success,
    required super.error,
  });
}
