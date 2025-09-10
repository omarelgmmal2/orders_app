import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../features/cart/cart_bloc.dart';

class CustomPlusOrMinusProduct extends StatefulWidget {
  final bool isProductDetails;
  final int id;
  final int index;

  const CustomPlusOrMinusProduct({
    super.key,
    this.isProductDetails = true,
    required this.id,
    required this.index,
  });

  @override
  State<CustomPlusOrMinusProduct> createState() =>
      _CustomPlusOrMinusProductState();
}

class _CustomPlusOrMinusProductState extends State<CustomPlusOrMinusProduct> {
  final bloc = KiwiContainer().resolve<CartBloc>();
  int amountProduct = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.isProductDetails ? 33.h : 26.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.r),
          color: const Color(0xff4C8613).withOpacity(0.11),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.isProductDetails ? 5.w : 2.w,
            vertical: widget.isProductDetails ? 3.h : 2.h,
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  if (widget.isProductDetails) {
                    if (bloc.amountProduct >= 1) {
                      bloc.add(CounterProductsEvent(isAdd: true));
                      setState(() {});
                    }
                  } else if (bloc.list[widget.index].amount >= 1) {
                    bloc.add(
                      UpdateProductCartEvent(
                        amount: ++bloc.list[widget.index].amount,
                        id: widget.id,
                      ),
                    );
                  }
                },
                child: SizedBox(
                  height: widget.isProductDetails ? 27.h : 21.h,
                  width: widget.isProductDetails ? 27.w : 21.w,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        widget.isProductDetails ? 9.r : 6.r,
                      ),
                      color: AppColor.white,
                    ),
                    child: Icon(Icons.add, color: AppColor.mainColor, size: 20),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.isProductDetails ? 15.w : 8.w,
                ),
                child: BlocBuilder(
                  bloc: bloc,
                  builder: (context, state) {
                    return Text(
                      '${widget.isProductDetails
                          ? bloc.amountProduct
                          : (state == UpdateAmountLoadingState)
                          ? bloc.list[widget.index].amount
                          : bloc.list[widget.index].amount}',
                      style: TextStyle(
                        color: AppColor.mainColor,
                        fontSize: widget.isProductDetails ? 15.sp : 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  if (widget.isProductDetails) {
                    if (bloc.amountProduct > 1) {
                      bloc.add(CounterProductsEvent(isAdd: false));
                      setState(() {});
                    }
                  } else if (bloc.list[widget.index].amount >= 2) {
                    bloc.add(
                      UpdateProductCartEvent(
                        amount: --bloc.list[widget.index].amount,
                        id: widget.id,
                      ),
                    );
                  }
                },
                child: SizedBox(
                  height: widget.isProductDetails ? 27.h : 21.h,
                  width: widget.isProductDetails ? 27.w : 21.w,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        widget.isProductDetails ? 9.r : 6.r,
                      ),
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.remove,
                      color: AppColor.mainColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
