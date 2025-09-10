import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/design/app_input.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import '../../../../../core/design/app_image.dart';

class ProductEvaluateItem extends StatelessWidget {
  const ProductEvaluateItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 16.h),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColor.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 17),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 8.h,
                    right: 6.w,
                    bottom: 8.h,
                    left: 10.w,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                    child: AppImage(
                      'https://thimar.amr.aait-d.com/storage/images/product/mMTiqG55dkQG0K95q8T3wSRpu6KHvwXIs7el8Cvj.jpg',
                      height: 64.h,
                      width: 75.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('طماطم', style: TextStyleTheme.textStyle16Bold),
                    Text(
                      'السعر / 1كجم',
                      style: TextStyleTheme.textStyle12Light,
                    ),
                    Row(
                      children: [
                        Text('45ر.س', style: TextStyleTheme.textStyle16Bold),
                        horizontalSpace(5),
                        Text(
                          '56ر.س',
                          style: TextStyleTheme.textStyle13Light.copyWith(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star_rate_rounded, color: Colors.orange, size: 20),
                Icon(Icons.star_rate_rounded, color: Colors.orange, size: 20),
                Icon(Icons.star_rate_rounded, color: Colors.orange, size: 20),
                Icon(Icons.star_rate_rounded, color: Colors.orange, size: 20),
                Icon(
                  Icons.star_border_rounded,
                  color: Color(0xffD5D5D5),
                  size: 20,
                ),
              ],
            ),
            verticalSpace(16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: SizedBox(
                height: 83.h,
                child: AppInput(
                  labelText: 'تعليق المنتج',
                  isFilled: false,
                  maxLines: 3,
                ),
              ),
            ),
            verticalSpace(11),
          ],
        ),
      ),
    );
  }
}
