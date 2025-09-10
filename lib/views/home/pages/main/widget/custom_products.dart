import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/features/products/products_bloc.dart';
import 'package:vegetable_orders_project/views/home/pages/main/widget/products_item.dart';

class CustomProducts extends StatefulWidget {
  const CustomProducts({super.key});

  @override
  State<CustomProducts> createState() => _CustomProductsState();
}

class _CustomProductsState extends State<CustomProducts> {
  final bloc = KiwiContainer().resolve<ProductsBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is ProductsLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: AppColor.mainColor),
          );
        } else if (state is ProductsSuccessState) {
          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: state.list.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 163 / 265,
              mainAxisSpacing: 26,
              crossAxisSpacing: 26,
            ),
            itemBuilder: (context, index) => ProductsItem(model: state.list[index]),
          );
        } else if (state is ProductsFailureState) {
          return Text(state.msg);
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
