import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design/app_image.dart';
import '../../../../core/utils/app_color.dart';

class CustomPayWay extends StatefulWidget {
  final bool isTrue;
  final bool isCard;
  final String imagePath;
  final String title;
  final int fontSize;
  final void Function() onTap;

  const CustomPayWay({
    this.isTrue = true,
    required this.imagePath,
    required this.title,
    this.fontSize = 16,
    required this.onTap,
    this.isCard = false,
  });

  @override
  State<CustomPayWay> createState() => _CustomPayWayState();
}

class _CustomPayWayState extends State<CustomPayWay> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: widget.onTap,
        child: SizedBox(
          height: 48.h,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.r),
              border:
              Border.all(
                width: widget.isTrue ? 3 : 1,
                color: AppColor.mainColor,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppImage(
                    widget.imagePath,
                    height: widget.isTrue ? 16.h : 14.h,
                  ),
                  Flexible(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: AppColor.mainColor,
                        fontSize: widget.isTrue
                            ? widget.fontSize.sp
                            : widget.isCard
                            ? 9.sp
                            : 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}