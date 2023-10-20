import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:synapsis_challenge/config/themes/colors.dart';

ThemeData theme() {
  return ThemeData(
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(SynapsisColor.primaryColor),
    ),
    primarySwatch: SynapsisColor.primaryColor,
    colorScheme: ColorScheme.fromSeed(
        seedColor: SynapsisColor.primaryColor, background: Colors.white),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Inter',
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Color(0xFFD6E4EC)),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: SynapsisColor.primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.red.shade300),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: Colors.red.shade300),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
      suffixIconColor: const Color(0xFF9DA7AD),
    ),
    useMaterial3: true,
  );
}
