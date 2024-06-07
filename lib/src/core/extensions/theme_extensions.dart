import 'package:flutter/material.dart';

import '../theme/colors/custom_colors.dart';
import '../theme/pk_theme.dart';
import '../theme/sizes/custom_radius.dart';
import '../theme/sizes/spacing.dart';
import '../theme/text_hierarchy/text_hierarchy.dart';

extension ThemeExtension on BuildContext {
  PKTheme get theme => PKTheme.i;
  CustomColors get colors => PKTheme.i.colors;
  Spacing get spacing => theme.spacing;
  CustomRadius get borderRadius => theme.radius;
  TextHierarchy get textHierarchy => theme.textHierarchy;
}
