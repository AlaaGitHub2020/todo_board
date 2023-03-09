import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_board/domain/core/utilities/colors.dart';

class AppTheme {
  const AppTheme._();

  static final _lightTheme = ThemeData.light().copyWith(
    primaryColor: AppColors.primaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.secondaryColor,
      background: AppColors.purpleColor1,
      error: AppColors.errorColor,
    ),
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    disabledColor: AppColors.grayColor1,
    appBarTheme:
        AppBarTheme(backgroundColor: AppColors.primaryColor, elevation: 10),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      filled: true,
      fillColor: AppColors.whiteColor1,
      hintStyle: GoogleFonts.montserrat(
        color: AppColors.primaryColor,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.secondaryColor.withOpacity(0.35),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.secondaryColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.primaryColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.primaryColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.errorColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.errorColor,
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.montserrat(
        fontSize: 18,
        color: AppColors.blackColor1,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.montserrat(
        fontSize: 18,
        color: AppColors.errorColor,
        fontWeight: FontWeight.bold,
      ),
      displayLarge: GoogleFonts.montserrat(
        fontSize: 18,
        color: AppColors.greenColor4,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.montserrat(
        fontSize: 18,
        color: AppColors.blackColor1,
        fontWeight: FontWeight.w500,
      ),
      displaySmall: GoogleFonts.montserrat(
        fontSize: 14,
        color: AppColors.blackColor1,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.montserrat(
        color: AppColors.blackColor1,
        fontWeight: FontWeight.w300,
        fontSize: 12,
      ),
      headlineSmall: GoogleFonts.montserrat(
        color: AppColors.whiteColor1,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      titleLarge: GoogleFonts.montserrat(
        color: AppColors.blackColor1,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      titleMedium: GoogleFonts.montserrat(
        color: AppColors.blackColor1,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      ),
      titleSmall: GoogleFonts.montserrat(
        color: AppColors.greenColor4,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    ),
    iconTheme: IconThemeData(
      color: AppColors.blackColor1,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          AppColors.primaryColor,
        ),
      ),
    ),
  );

  static final _darkTheme = ThemeData.dark().copyWith(
    primaryColor: AppColors.primaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: AppColors.secondaryColor,
        background: AppColors.blackColor1,
        error: AppColors.errorColor),
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    disabledColor: AppColors.grayColor1,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintStyle: GoogleFonts.montserrat(
        color: AppColors.primaryColor,
      ),
      filled: true,
      fillColor: AppColors.primaryColor.withOpacity(0.5),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.secondaryColor.withOpacity(0.35),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.secondaryColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.primaryColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.primaryColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.errorColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.errorColor,
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.montserrat(
        fontSize: 18,
        color: AppColors.blackColor1,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.montserrat(
        fontSize: 18,
        color: AppColors.errorColor,
        fontWeight: FontWeight.bold,
      ),
      displayLarge: GoogleFonts.montserrat(
        fontSize: 18,
        color: AppColors.greenColor2,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.montserrat(
        fontSize: 18,
        color: AppColors.whiteColor1,
        fontWeight: FontWeight.w500,
      ),
      displaySmall: GoogleFonts.montserrat(
        fontSize: 14,
        color: AppColors.whiteColor1,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.montserrat(
        color: AppColors.whiteColor1,
        fontWeight: FontWeight.w300,
        fontSize: 12,
      ),
      headlineSmall: GoogleFonts.montserrat(
        color: AppColors.blackColor1,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      titleLarge: GoogleFonts.montserrat(
        color: AppColors.whiteColor1,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      titleMedium: GoogleFonts.montserrat(
        color: AppColors.whiteColor2,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      ),
      titleSmall: GoogleFonts.montserrat(
        color: AppColors.greenColor3,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    ),
    iconTheme: IconThemeData(
      color: AppColors.whiteColor1,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          AppColors.primaryColor,
        ),
      ),
    ),
  );

  static ThemeData light() {
    return _lightTheme;
  }

  static ThemeData dark() {
    return _darkTheme;
  }
}
