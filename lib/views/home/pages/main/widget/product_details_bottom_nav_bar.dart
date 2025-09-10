import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/utils/text_style_theme.dart';
import '../../../../../features/cart/cart_bloc.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../../model/products_model.dart';
import '../../../../../model/search_model.dart';

class ProductDetailsBottomNavBar extends StatefulWidget {
  final ProductsModel? model;
  final SearchResult? searchModel;

  const ProductDetailsBottomNavBar({super.key, this.model, this.searchModel});

  @override
  State<ProductDetailsBottomNavBar> createState() =>
      _ProductDetailsBottomNavBarState();
}

class _ProductDetailsBottomNavBarState
    extends State<ProductDetailsBottomNavBar> {
  final cartBloc = KiwiContainer().resolve<CartBloc>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        cartBloc.add(
          StoreProductCartEvent(
            searchModel: widget.searchModel,
            id: widget.model?.id ?? widget.searchModel!.id,
            model: widget.model,
            isProduct: true,
            amount: cartBloc.amountProduct,
          ),
        );
      },
      child: Container(
        color: AppColor.mainColor,
        height: 60.h,
        width: double.infinity.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 19.w),
          child: BlocBuilder(
            bloc: cartBloc,
            builder: (context, state) {
              if (state is AddToCartLoadingState) {
                return Center(
                  child: SizedBox(
                    width: 200.w,
                    child: LinearProgressIndicator(color: Color(0xff61B80C)),
                  ),
                );
              }
              return Row(
                children: [
                  SizedBox(
                    height: 32.h,
                    width: 32.h,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.r),
                        color: const Color(0xff6AA431),
                      ),
                      child: AppImage(
                        AppImages.cart,
                        color: AppColor.white,
                        height: 20.h,
                        width: 20.h,
                      ),
                    ),
                  ),
                  horizontalSpace(9),
                  Text(
                    LocaleKeys.product_details_add_to_cart.tr(),
                    style: TextStyleTheme.textStyle15Bold.copyWith(
                      color: AppColor.white,
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder(
                    bloc: cartBloc,
                    builder: (context, state) {
                      if (state is AddCounterSuccessState) {
                        return Text(
                          '${((widget.model?.price ?? widget.searchModel!.price!) * cartBloc.amountProduct).toDouble().toStringAsFixed(2)} ${LocaleKeys.r_s.tr()}',
                          style: TextStyleTheme.textStyle15Bold.copyWith(
                            color: AppColor.white,
                          ),
                        );
                      } else {
                        return Text(
                          '${((widget.model?.price ?? widget.searchModel!.price!) * cartBloc.amountProduct).toDouble().toStringAsFixed(2)} ${LocaleKeys.r_s.tr()}',
                          style: TextStyleTheme.textStyle15Bold.copyWith(
                            color: AppColor.white,
                          ),
                        );
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
