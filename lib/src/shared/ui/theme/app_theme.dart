
import 'package:flutter/material.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_colors.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_text_style.dart';

class AppTheme {
  static ThemeData theme = ThemeData.dark();
  
  static ThemeData appTheme = theme.copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    useMaterial3: true,
    textTheme: const TextTheme(
      titleLarge: AppTextStyle.titleLarge,
      titleMedium: AppTextStyle.titleMedium,
      bodyMedium: AppTextStyle.bodyMedium,
      bodySmall: AppTextStyle.bodySmall,
    ),
  );
    
}