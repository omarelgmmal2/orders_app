import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/logic/helper_methods.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/utils/text_style_theme.dart';
import '../../../../../model/get_categories_model.dart';
import 'category_view.dart';

class CategoriesItem extends StatelessWidget {
  final GetCategoriesModel model;

  const CategoriesItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            navigateTo(
              toPage: CategoryView(id: model.id, model: model),
            );
          },
          child: Container(
            height: 73.h,
            width: 73.h,
            margin: EdgeInsets.only(top: 18.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: AppImage(model.media),
          ),
        ),
        Text(
          textAlign: TextAlign.center,
          model.name,
          style: TextStyleTheme.textStyle20Medium,
        ),
      ],
    );
  }
}
