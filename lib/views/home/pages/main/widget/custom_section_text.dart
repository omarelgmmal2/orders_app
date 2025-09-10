import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/text_style_theme.dart';

class CustomSectionText extends StatelessWidget {
  final String text;
  const CustomSectionText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: Text(
        text,
        style: TextStyleTheme.textStyle15ExtraBold,
      ),
    );
  }
}
