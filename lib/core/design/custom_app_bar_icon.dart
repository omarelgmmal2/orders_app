import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarIcon extends StatelessWidget {
  const CustomAppBarIcon({
    super.key,
    this.child,
    this.isBack = true,
    this.height = 32,
    this.width = 32,
    this.color,
    this.onTap,
  });

  final Widget? child;
  final bool isBack;
  final double height;
  final double width;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isBack
          ? () {
              Navigator.pop(context, true);
              if (FocusScope.of(context).hasFocus) {
                FocusScope.of(context).unfocus();
              }
            }
          : onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isBack ? 9.r : 7.r),
          color: color ?? const Color(0xff4C8613).withOpacity(0.13),
        ),
        height: height,
        width: width,
        child:
            child ??
            const Icon(
              Icons.arrow_back_ios_rounded,
              size: 20,
              color: Color(0xff4C8613),
            ),
      ),
    );
  }
}
