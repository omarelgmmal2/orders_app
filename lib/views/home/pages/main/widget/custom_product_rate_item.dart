import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/features/products_rate/products_rate_bloc.dart';
import '../../../../../core/utils/spacing.dart';
import 'item_product_rate.dart';

class CustomProductRateItem extends StatefulWidget {
  final int id;
  const CustomProductRateItem({super.key, required this.id});

  @override
  State<CustomProductRateItem> createState() => _CustomProductRateItemState();
}

class _CustomProductRateItemState extends State<CustomProductRateItem> {
  final bloc = KiwiContainer().resolve<ProductRateBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(ProductsRateEvent(id: widget.id));
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
        if (state is ProductsRateLoadingState) {
          return Center(child: CircularProgressIndicator(color: AppColor.mainColor));
        } else if (state is ProductsRateSuccessState) {
          return SizedBox(
            height: 90.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  ItemProductRate(
                      model: state.list[index],
                  ),
              separatorBuilder: (context, index) => horizontalSpace(10),
              itemCount: state.list.length,
            ),
          );
        } else if (state is ProductsRateFailureState) {
          return Center(child: Text(state.msg));
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
