import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import '../../../../../core/design/custom_app_bar_icon.dart';
import '../../../../../model/question_model.dart';

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({required this.model});
  final QuestionModel model;
  @override
  State<CustomExpansionTile> createState() => CustomExpansionTileState();
}

class CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _iconIsDown = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: EdgeInsets.symmetric(horizontal: 16.w),
      tilePadding: EdgeInsets.symmetric(horizontal: 16.w),
      title: Text(
        widget.model.question,
        style: TextStyleTheme.textStyle15Bold,
      ),
      trailing: CustomAppBarIcon(
        isBack: false,
        height: 25.h,
        width: 25.h,
        child: Icon(
          !_iconIsDown
              ? Icons.keyboard_arrow_down_rounded
              : Icons.keyboard_arrow_up_rounded,
          color: AppColor.mainColor,
        ),
      ),
      children: [
        Text(
          widget.model.answer,
          style: TextStyleTheme.textStyle15Light.copyWith(
            color: Color(0xff828282),
          ),
        ),
      ],
      onExpansionChanged: (value) {
        _iconIsDown = value;
        setState(() {});
      },
    );
  }
}