import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/utils/text_style_theme.dart';

class ItemMyAccount extends StatelessWidget {
  final String title;
  final String icon;
  final bool isLogout;

  const ItemMyAccount({
    required this.title,
    required this.icon,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Row(
        children: [
          !isLogout
              ? AppImage(
                  'assets/icons/account/$icon.svg',
                  height: 18.h,
                  width: 18.h,
                  fit: BoxFit.scaleDown,
                )
              : const SizedBox(),
          !isLogout ? horizontalSpace(8) : const SizedBox(),
          Text(title, style: TextStyleTheme.textStyle14Bold),
          const Spacer(),
          Transform.flip(
            flipX: context.locale.languageCode == 'ar' ? false : true,
            child: AppImage(
              !isLogout
                  ? 'assets/icons/line_arrow_acount.svg'
                  : 'assets/icons/account/$icon.svg',
              height: 18.h,
              width: 18.h,
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
    );
  }
}
