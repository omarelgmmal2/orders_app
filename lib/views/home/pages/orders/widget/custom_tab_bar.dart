import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';

import '../../../../../core/utils/font_weight_helper.dart';

class CustomTabBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomTabBar({
    super.key,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();

  @override
  Size get preferredSize => Size.fromHeight(40.h);
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 15.h),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffF3F3F3),
            ),
            borderRadius: BorderRadius.circular(10.r),
        ),
        child: TabBar(
          padding: EdgeInsets.all(6.h),
          indicatorPadding: const EdgeInsets.fromLTRB(-45, 0, -45, 0),
          unselectedLabelStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
          unselectedLabelColor: const Color(0xffA2A1A4),
          labelStyle: TextStyleTheme.textStyle15Bold.copyWith(
            color: AppColor.white,
          ),
          labelColor: AppColor.white,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: AppColor.mainColor,
          ),
          tabs: [
            Tab(
              height: 40.h,
              child: Text(
                context.locale.languageCode == "en" ? "Active" : "الحاليه",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
            ),
            Tab(
              height: 40,
              child: Text(
                context.locale.languageCode == "en" ? "Expired" : 'المنتهية',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}