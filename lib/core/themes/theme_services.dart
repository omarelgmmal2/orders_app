import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import '../utils/app_color.dart';

class ThemeServices {
  final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColor.white,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0.0,
      color: AppColor.white,
      titleTextStyle: TextStyleTheme.textStyle20Bold,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(343.w, 60.h),
        backgroundColor: AppColor.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15.r),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: TextStyleTheme.textStyle16Light,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColor.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: BorderSide(
          color: Color(0xffF3F3F3),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: BorderSide(
          color: Color(0xffF3F3F3),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: BorderSide(
          color: Color(0xffF3F3F3),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: BorderSide(
          color: AppColor.mainColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: BorderSide(
          color: AppColor.red,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: BorderSide(
          color: AppColor.red,
        ),
      ),
    ),
  );
}