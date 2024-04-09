import 'package:flutter/material.dart';
import 'package:meteo_sncf/app_colors.dart';

class AppTheme {
  static ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: AppColors.primaryBackground,
        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          filled: true,
          fillColor: AppColors.secondaryBackground,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(fontWeight: FontWeight.bold),
            ),
            foregroundColor:
                MaterialStateProperty.all<Color>(AppColors.actionLightBlue),
            side: MaterialStateProperty.all<BorderSide>(
              BorderSide(color: AppColors.actionLightBlue),
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            ),
          ),
        ),
        useMaterial3: true,
      );
}
