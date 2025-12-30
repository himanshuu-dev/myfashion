import 'package:ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get theme => ThemeData(
    scaffoldBackgroundColor: AppColors.offWhite,
    primaryColor: AppColors.titleActive,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.titleActive,
      onPrimary: AppColors.offWhite,
      secondary: AppColors.primary,
      onSecondary: AppColors.offWhite,
      error: Colors.red,
      onError: AppColors.offWhite,
      surface: AppColors.offWhite,
      onSurface: AppColors.label,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.tenorSans(
        color: Color(0xff202224),
        letterSpacing: 4,
      ),
      titleMedium: GoogleFonts.tenorSans(color: Color(0xff202224)),
      titleSmall: GoogleFonts.tenorSans(color: Color(0xff202224)),
      bodyLarge: GoogleFonts.tenorSans(color: AppColors.label),
      bodyMedium: GoogleFonts.tenorSans(color: AppColors.label),
      bodySmall: GoogleFonts.tenorSans(color: Color(0xff727272)),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.offWhite,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: GoogleFonts.tenorSans(
        color: Color(0xff202224),
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Colors.grey.shade200,
    ),
    dividerColor: AppColors.border,
    dividerTheme: DividerThemeData(color: AppColors.border),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.titleActive),
        foregroundColor: WidgetStatePropertyAll(AppColors.offWhite),
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.tenorSans(color: Color(0xff202224)),
        ),
        minimumSize: WidgetStatePropertyAll(Size(187, 40)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.all(Radius.circular(0)),
          ),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        foregroundColor: WidgetStatePropertyAll(AppColors.titleActive),
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.tenorSans(color: Color(0xff202224)),
        ),
        minimumSize: WidgetStatePropertyAll(Size(187, 40)),
        side: WidgetStatePropertyAll(BorderSide(color: AppColors.border)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.all(Radius.circular(0)),
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(GoogleFonts.tenorSans(fontSize: 17)),
        foregroundColor: WidgetStatePropertyAll(AppColors.titleActive),
        iconColor: WidgetStatePropertyAll(AppColors.titleActive),
      ),
    ),
  );
}
