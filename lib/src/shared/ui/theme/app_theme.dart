
import 'package:flutter/material.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_colors.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_text_style.dart';

class AppTheme {
  static ThemeData theme = ThemeData();
  
  static ThemeData appTheme = theme.copyWith(
    colorScheme: theme.colorScheme.copyWith(
      background: AppColors.backgroundColor,
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
    ),
    textTheme: const TextTheme(
      titleLarge: AppTextStyle.titleLarge,
      titleMedium: AppTextStyle.titleMedium,
      bodyMedium: AppTextStyle.bodyMedium,
      bodySmall: AppTextStyle.bodySmall,
    ),
  );
    
}