import 'dart:ui';

import '../../theme/colors/custom_colors.dart';

class T1Colors implements CustomColors {
  @override
  Color get accent => const Color(0xFF00C853); // Green A700

  @override
  Color get black => const Color(0xFF000000); // Black

  @override
  Color get dividerColor => const Color(0xFFBDBDBD); // Grey 400

  @override
  Color get primary => const Color(0xFF1E88E5); // Blue 600

  @override
  Color get primaryDark => const Color(0xFF1565C0); // Blue 800

  @override
  Color get primaryLight => const Color(0xFFBBDEFB); // Blue 100

  @override
  Color get primaryTextColor => const Color(0xFFFFFFFF); // White

  @override
  Color get secondary => const Color(0xFFFFA000); // Amber 600

  @override
  Color get secondaryDark => const Color(0xFFFF8F00); // Amber 700

  @override
  Color get secondaryLight => const Color(0xFFFFE082); // Amber 200

  @override
  Color get secondaryTextColor => const Color(0xFF000000); // Black

  @override
  Color get transparent => const Color(0x00000000); // Transparent

  @override
  Color get white => const Color(0xFFFFFFFF); // White

  @override
  Color get success => const Color(0xFF00C853); // Green A700

  @override
  Color get error => const Color(0xFFE53935); // Red 600
}
