import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../features/categories/get_category_bloc.dart';
import 'categories_item.dart';

class CustomCategories extends StatefulWidget {
  const CustomCategories({super.key});

  @override
  State<CustomCategories> createState() => _CustomCategoriesState();
}

class _CustomCategoriesState extends State<CustomCategories> {
  final bloc = KiwiContainer().resolve<GetCategoryBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is GetCategoryLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: AppColor.mainColor),
          );
        } else if (state is GetCategorySuccessState) {
          return SizedBox(
            height: 120.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  CategoriesItem(model: state.model[index]),
              separatorBuilder: (context, index) => horizontalSpace(18),
              itemCount: state.model.length,
            ),
          );
        } else if (state is GetCategoryFailureState) {
          return Text(state.msg);
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
