import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';

class CustomFormInput extends StatelessWidget {
  final String labelText;
  final int maxLines;
  final bool isFillColor;
  final bool isTitle;
  final bool isPhone;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomFormInput({
    super.key,
    required this.labelText,
    this.maxLines = 1,
    this.isFillColor = false,
    this.isTitle = false,
    this.isPhone = false,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      style: TextStyle(color: AppColor.mainColor, fontSize: 15.sp),
      controller: controller,
      maxLines: maxLines,
      keyboardType: isPhone ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        labelStyle: TextStyle(
            fontSize: isFillColor ? 15.sp : 13.sp,
            fontWeight: FontWeight.w300,
        ),
        labelText: labelText,
        filled: true,
        fillColor: isFillColor ? const Color(0xffFAFFF5) : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color:
            isFillColor ? const Color(0xff8AC253) : const Color(0xffDCDCDC),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(
            color: isFillColor
                ? const Color(0xff8AC253)
                : !isTitle
                ? const Color(0xffDCDCDC)
                : Colors.white,
          ),
        ),
      ),
    );
  }
}