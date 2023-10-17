import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../colors/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarBrightness: Brightness.dark,
      ),
    ),
  );

  static ThemeData myTheme = ThemeData(
    // useMaterial3: true,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(size: 30.sp),
      backgroundColor: AppColors.c_111015,
      selectedItemColor: Colors.yellow,
      unselectedItemColor: Colors.white,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedLabelStyle: const TextStyle(color: Colors.white)
    ),
    appBarTheme: AppBarTheme(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
      ),
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontSize: 30,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      fontFamily: "Montserrat"
      ),
      backgroundColor: AppColors.c_111015,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.c_111015,
        statusBarBrightness: Brightness.light,
      ),
    ),
  );
}
