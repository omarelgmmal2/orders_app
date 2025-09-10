import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/features/similar_products/similar_products_bloc.dart';
import 'package:vegetable_orders_project/views/home/pages/main/widget/products_item.dart';

class CustomListSimilarProducts extends StatefulWidget {
  final int id;
  const CustomListSimilarProducts({super.key, required this.id});

  @override
  State<CustomListSimilarProducts> createState() =>
      _CustomListSimilarProductsState();
}

class _CustomListSimilarProductsState extends State<CustomListSimilarProducts> {
  final bloc = KiwiContainer().resolve<GetSimilarProductBloc>();
  @override
  void initState() {
    super.initState();
    bloc.add(GetSimilarProductsEvent(id: widget.id));
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is GetSimilarProductLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: AppColor.mainColor),
          );
        } else if (state is GetSimilarProductSuccessState) {
          return SizedBox(
            height: 250.h,
            width: double.infinity.w,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              separatorBuilder: (context, index) {
                return horizontalSpace(18);
              },
              scrollDirection: Axis.horizontal,
              itemCount: state.model.length,
              itemBuilder: (context, index) =>
                  ProductsItem(model: state.model[index]),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}