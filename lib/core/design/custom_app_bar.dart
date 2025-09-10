import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/text_style_theme.dart';
import 'custom_app_bar_icon.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.thereIsIcon = true,
    this.bottom,
    this.height = 55,
  });
  final String title;
  final bool thereIsIcon;
  final PreferredSizeWidget? bottom;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Stack(
          children: [
            AppBar(
              forceMaterialTransparency: true,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Padding(
                padding: EdgeInsets.only(top: 14.h),
                child: Text(
                  title,
                  style: TextStyleTheme.textStyle20Bold,
                ),
              ),
              bottom: bottom,
            ),
            thereIsIcon
                ? const Positioned(
              top: 22,
              child: CustomAppBarIcon(),
            )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}