import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/design/app_button.dart';
import 'package:vegetable_orders_project/core/logic/helper_methods.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import 'package:vegetable_orders_project/features/cart/cart_bloc.dart';
import 'package:vegetable_orders_project/features/search_product/search_products_bloc.dart';
import 'package:vegetable_orders_project/generated/locale_keys.g.dart';
import 'package:vegetable_orders_project/views/home/home_view.dart';
import '../../core/design/app_image.dart';
import '../../core/design/custom_app_bar_icon.dart';
import '../../core/design/custom_outline_button.dart';
import '../../model/products_model.dart';
import '../../model/search_model.dart';
import '../home/cart_and_orders/cart_view.dart';

class SuccessAddToCartSheet extends StatelessWidget {
  final ProductsModel? model;
  final SearchResult? searchModel;
  const SuccessAddToCartSheet({super.key, this.model, this.searchModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 215.h,
        child: Padding(
          padding: EdgeInsets.only(top: 16.h, right: 20.w, left: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    CustomAppBarIcon(
                      isBack: false,
                      height: 18.w,
                      width: 18.w,
                      child: Icon(
                        Icons.check_rounded,
                        size: 14,
                        color: AppColor.mainColor,
                      ),
                    ),
                    horizontalSpace(8),
                    Text(
                      LocaleKeys.product_details_product_added_to_cart.tr(),
                      style: TextStyleTheme.textStyle14Bold,
                    ),
                  ],
                ),
                verticalSpace(20),
                _Item(model: model, searchModel: searchModel),
                verticalSpace(16),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 47.h,
                        child: AppButton(
                          text: LocaleKeys.product_details_go_to_cart.tr(),
                          textStyle: TextStyleTheme.textStyle15Bold.copyWith(
                            color: AppColor.white,
                          ),
                          onPressed: () {
                            KiwiContainer().resolve<CartBloc>().amountProduct = 1;
                            navigateTo(
                              toPage: const HomeView(),
                              isRemove: true,
                            );
                            KiwiContainer().resolve<SearchProductsBloc>()
                              ..add(SearchProductsEvent(text: ''))
                              ..textController.clear()
                              ..search.clear()
                              ..isNotFound = false;
                            FocusManager.instance.primaryFocus?.unfocus();
                            navigateTo(toPage: const CartView());
                            FocusScope.of(context).unfocus();
                            Navigator.canPop(context);
                          },
                        ),
                      ),
                    ),
                    horizontalSpace(16),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity.w,
                        child: SizedBox(
                          height: 47.h,
                          child: CustomOutlineButton(
                            onPress: () {
                              KiwiContainer()
                                      .resolve<CartBloc>()
                                      .amountProduct =
                                  1;

                              navigateTo(
                                toPage: const HomeView(),
                                isRemove: true,
                              );
                              KiwiContainer().resolve<SearchProductsBloc>()
                                ..add(SearchProductsEvent(text: ''))
                                ..textController.clear()
                                ..search.clear()
                                ..isNotFound = false;

                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            title: LocaleKeys.product_details_browse_offers
                                .tr(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Item extends StatefulWidget {
  final ProductsModel? model;
  final SearchResult? searchModel;
  const _Item({this.model, this.searchModel});

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {

  final bloc = KiwiContainer().resolve<CartBloc>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(11).w,
          child: AppImage(
            widget.model?.mainImage ?? widget.searchModel!.mainImage,
            height: 61.h,
            width: 66.w,
            fit: BoxFit.cover,
          ),
        ),
        horizontalSpace(11),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.model?.title ?? widget.searchModel!.title,
              style: TextStyleTheme.textStyle12Medium,
            ),
            verticalSpace(5),
            Text(
              '${LocaleKeys.product_details_amount.tr()} : ${bloc.amountProduct}',
              style: TextStyleTheme.textStyle12Light,
            ),
            verticalSpace(2),
            Text(
              '${widget.model?.price ?? widget.searchModel!.price} ${LocaleKeys.r_s.tr()}',
              style: TextStyleTheme.textStyle16Medium,
            ),
          ],
        ),
      ],
    );
  }
}
