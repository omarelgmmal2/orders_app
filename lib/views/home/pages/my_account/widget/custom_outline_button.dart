import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';

class CustomOutlineButton extends StatelessWidget {
  final void Function() onTap;
  final String title;
  const CustomOutlineButton({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          DottedBorder(
            child: SizedBox(
              height: 48.h,
              width: double.infinity.w,
            ),
          ),
          SizedBox(
              height: 52.h,
              width: double.infinity.w,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 239, 255, 218),
                    borderRadius: BorderRadius.circular(15.r),
                ),
                child: Center(
                    child: Text(
                      title,
                      style: TextStyleTheme.textStyle15Bold,
                    ),
                ),
              ),
          )
        ],
      ),
    );
  }
}