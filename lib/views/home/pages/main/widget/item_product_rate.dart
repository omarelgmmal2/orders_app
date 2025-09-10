import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/model/products_rate_model.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/utils/text_style_theme.dart';

class ItemProductRate extends StatelessWidget {
  final ProductsRateModel model;

  const ItemProductRate({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13.w,vertical: 6.h),
      height: 87.h,
      width: 267.w,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    model.clientName,
                    style: TextStyleTheme.textStyle16Bold.copyWith(
                      color: AppColor.black,
                    ),
                  ),
                  horizontalSpace(7),
                  Text(
                    model.value.toString(),
                    style: TextStyleTheme.textStyle16Bold.copyWith(
                      color: Color(0xffFF9529),
                    ),
                  ),
                ],
              ),
              Text(
                model.comment,
                maxLines: 2,
                style: TextStyleTheme.textStyle12Regular,
              ),
            ],
          ),
          Spacer(),
          Container(
            height: 55.h,
            width: 55.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: AppImage(
                model.clientImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}