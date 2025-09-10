import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/utils/text_style_theme.dart';
import '../../../../../generated/locale_keys.g.dart';
import 'custom_my_data.dart';

class CustomAppBarAccount extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBarAccount();

  @override
  State<CustomAppBarAccount> createState() => CustomAppBarAccountState();

  @override
  Size get preferredSize => Size.fromHeight(210.h);
}

class CustomAppBarAccountState extends State<CustomAppBarAccount> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.r),
          bottomRight: Radius.circular(40.r),
        ),
        child: Stack(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 210.h,
              backgroundColor: Theme.of(context).primaryColor,
              centerTitle: true,
              title: Column(
                children: [
                  verticalSpace(25),
                  Text(
                    LocaleKeys.my_account_my_account.tr(),
                    style: TextStyleTheme.textStyle20Bold.copyWith(
                      color: AppColor.white,
                    ),
                  ),
                  verticalSpace(20),
                  const CustomMyData(),
                ],
              ),
            ),
            Positioned(
              top: -55.h,
              right: -100.w,
              child: CircleAvatar(
                radius: 85.r,
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: -70.h,
              left: -110.w,
              child: CircleAvatar(
                radius: 105.r,
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),
            Positioned(
              bottom: -60.h,
              left: -80.w,
              child: CircleAvatar(
                radius: 85.r,
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),
            Positioned(
              bottom: -40.h,
              right: -60.w,
              child: CircleAvatar(
                radius: 85.r,
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
