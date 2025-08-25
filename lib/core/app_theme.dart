import 'package:finance_tracker_app/core/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get appTheme => ThemeData(
        scaffoldBackgroundColor: AppColors.lightBlue,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: AppColors.darkBlue, foregroundColor: AppColors.lightForegroundText),
        appBarTheme: AppBarTheme(color: AppColors.lightBlue),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: AppColors.lightBlue),
          ),
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: AppColors.containerColor,
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: AppColors.lightBlue))),
          menuStyle: MenuStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.containerColor),
            side: WidgetStateProperty.all(
              BorderSide(
                color: AppColors.lightBlue,
              ),
            ),
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColors.containerColor),
      );
}
