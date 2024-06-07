import 'dart:ui';

import '../../theme/colors/custom_colors.dart';

class T2Colors implements CustomColors {
  @override
  Color get accent => const Color(0xFFFF5722); // Deep Orange 500

  @override
  Color get black => const Color(0xFF212121); // Grey 900

  @override
  Color get dividerColor => const Color(0xFFE0E0E0); // Grey 300

  @override
  Color get primary => const Color(0xFF795548); // Brown 500

  @override
  Color get primaryDark => const Color(0xFF5D4037); // Brown 700

  @override
  Color get primaryLight => const Color(0xFFD7CCC8); // Brown 100

  @override
  Color get primaryTextColor => const Color(0xFFFFFFFF); // White

  @override
  Color get secondary => const Color(0xFF8BC34A); // Light Green 500

  @override
  Color get secondaryDark => const Color(0xFF689F38); // Light Green 700

  @override
  Color get secondaryLight => const Color(0xFFDCEDC8); // Light Green 100

  @override
  Color get secondaryTextColor => const Color(0xFF000000); // Black

  @override
  Color get transparent => const Color(0x00000000); // Transparent

  @override
  Color get white => const Color(0xFFFFFFFF); // White

  @override
  Color get success => const Color(0xFF8BC34A); // Light Green 500

  @override
  Color get error => const Color(0xFFE53935); // Red 600
}
