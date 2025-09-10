import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../model/notifications_model.dart';

class ItemNotifications extends StatelessWidget {
  final Notifications model;
  const ItemNotifications({required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(11.r),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.035), blurRadius: 20),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(end: 10.w),
                height: 33.h,
                width: 33.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.r),
                  color: const Color(0xff4C8613).withAlpha(13),
                ),
                child: Padding(
                  padding: EdgeInsets.all(6.h),
                  child: AppImage(model.image ?? AppImages.vegetableBasket),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.title, style: TextStyleTheme.textStyle12Medium),
                    Text(model.body, style: TextStyleTheme.textStyle10Regular),
                    Text(
                      model.createdAt,
                      style: TextStyleTheme.textStyle10Regular.copyWith(
                        color: Color(0xff091022),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
