import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/design/app_button.dart';
import 'package:vegetable_orders_project/core/logic/helper_methods.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import 'package:vegetable_orders_project/generated/locale_keys.g.dart';
import 'package:vegetable_orders_project/views/home/home_view.dart';
import '../../core/design/app_image.dart';

class ThankYouSheet extends StatelessWidget {
  const ThankYouSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            verticalSpace(14),
            AppImage(AppImages.thankYou, height: 215.h, width: 240.w),
            verticalSpace(16),
            Text(
              LocaleKeys.complete_order_thank_you.tr(),
              style: TextStyleTheme.textStyle20Bold,
            ),
            SizedBox(height: 6.h),
            Text(
              LocaleKeys.complete_order_you_can_follow.tr(),
              style: TextStyleTheme.textStyle16Medium.copyWith(
                color: const Color(0xffACACAC),
              ),
            ),
            verticalSpace(26),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AppButton(
                      text: LocaleKeys.home_nav_my_orders.tr(),
                      onPressed: () {
                        navigateTo(
                          toPage: const HomeView(isNavigateToOrder: true),
                          isRemove: true,
                        );
                      },
                    ),
                  ),
                  horizontalSpace(16),
                  Expanded(
                    child: SizedBox(
                      height: 55.h,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(
                          LocaleKeys.home_nav_main_page.tr(),
                          style: TextStyleTheme.textStyle15Bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(22),
          ],
        ),
      ),
    );
  }
}
