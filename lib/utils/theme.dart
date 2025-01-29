import 'package:bank_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.poppinsTextTheme(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(callToActionColor),
      minimumSize: WidgetStatePropertyAll(Size.fromHeight(50)),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    ),
  ),
);
