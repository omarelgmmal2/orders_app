import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import '../utils/app_color.dart';
import '../utils/app_images.dart';
import '../utils/text_style_theme.dart';
import 'app_image.dart';

class AppInput extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final void Function(String)? onFieldSubmitted;
  final String? labelText,icon;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final bool isPassword,isPhone;
  final Widget? suffixIcon;
  final double paddingBottom, paddingTop;
  final Color? fillColor;
  final bool? isFilled;
  final int? maxLines;
  final Function(String)? onChanged;
  const AppInput({
    super.key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.onFieldSubmitted,
    this.labelText,
    this.validator,
    this.textInputAction,
    this.isPassword = false,
    this.isPhone = false,
    this.suffixIcon,
    this.paddingBottom = 8,
    this.paddingTop = 0,
    this.fillColor,
    this.isFilled,
    this.icon,
    this.onChanged,
    this.maxLines,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {

  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(
          bottom: widget.paddingBottom.h,
          top: widget.paddingTop.h,
      ),
      child: TextFormField(
        maxLines: isPasswordHidden ? 1 : (widget.maxLines ?? 1),
        onChanged: widget.onChanged,
        style: TextStyleTheme.textStyle15Bold,
        controller: widget.controller,
        cursorHeight: 17.h,
        cursorColor: AppColor.mainColor,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        decoration: InputDecoration(
          fillColor: widget.fillColor,
          filled: widget.isFilled,
          labelText: widget.labelText,
          labelStyle: TextStyleTheme.textStyle11Regular,
          prefixIcon: AppImage(
            widget.icon ?? "",
            height: 22.h,
            width: 22.h,
            fit: BoxFit.scaleDown,
          ),
          suffixIcon: widget.isPassword ? IconButton(
            icon: Icon(
              isPasswordHidden ? Icons.visibility_off : Icons.visibility,
              color: AppColor.gray,
            ),
            onPressed: () {
              isPasswordHidden = !isPasswordHidden;
              setState(() {});
            },
          ) : widget.suffixIcon,
          icon: widget.isPhone
              ? Container(
            height: 60.h,
            width: 69.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                color: Color(0xffF3F3F3),
              ),
            ),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppImage(
                  AppImages.sadiaFlag,
                  height: 20.h,
                  width: 32.w,
                  fit: BoxFit.cover,
                ),
                verticalSpace(2),
                Text(
                  "+966",
                  style: TextStyleTheme.textStyle15Medium,
                ),
              ],
            ),
          )
              : null,
        ),
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        obscureText: isPasswordHidden && widget.isPassword,
        onFieldSubmitted: widget.onFieldSubmitted,
        validator: widget.validator,
        textInputAction: widget.textInputAction,
      ),
    );
  }
}
