import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/design/app_button.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/views/home/cart_and_orders/widget/custom_orders_money.dart';
import 'package:vegetable_orders_project/views/home/cart_and_orders/widget/item_order.dart';
import '../../../core/design/app_image.dart';
import '../../../core/design/custom_app_bar.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/text_style_theme.dart';
import '../../../features/cart/cart_bloc.dart';
import '../../../generated/locale_keys.g.dart';
import 'complete_order_view.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final bloc = KiwiContainer().resolve<CartBloc>();

  @override
  initState() {
    super.initState();
    bloc.add(ShowCartEvent(isLoading: true));
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is GetCartLoadingState) {
            return Center(
              child: CircularProgressIndicator(color: AppColor.mainColor),
            );
          } else if (bloc.list.isEmpty) {
            return SizedBox(
              width: double.infinity.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppImage(AppImages.noDataCart, width: 200.w),
                  verticalSpace(8),
                  Text(
                    'لا توجد طلبات',
                    style: TextStyleTheme.textStyle25Bold,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                if (FocusScope.of(context).hasFocus) {
                  FocusScope.of(context).unfocus();
                }
              },
              child: Scaffold(
                appBar: CustomAppBar(
                  title: LocaleKeys.cart_cart.tr(),
                  thereIsIcon: true,
                ),
                body: Padding(
                  padding: EdgeInsets.all(16.h),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.all(0.h),
                          itemBuilder: (context, index) =>
                              ItemOrder(index: index, model: bloc.list[index]),
                          itemCount: bloc.list.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                        ),
                      ),
                      verticalSpace(10),
                      Column(
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 0),
                                  blurRadius: 17,
                                  color: const Color(0xff000000).withOpacity(0.02),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: 17.w,
                                top: 7.h,
                                end: 7.w,
                                bottom: 7.h,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 40.h,
                                      child: TextFormField(
                                        autofocus: false,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              9.r,
                                            ),
                                            borderSide: BorderSide(
                                              color: AppColor.mainColor,
                                            ),
                                          ),
                                          labelText: LocaleKeys
                                              .cart_you_have_coupon
                                              .tr(),
                                          labelStyle: TextStyleTheme
                                              .textStyle12Light
                                              .copyWith(
                                                color: Color(0xffB9C9A8),
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  horizontalSpace(5),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6.h),
                                    height: 37.h,
                                    width: 56.w,
                                    decoration: BoxDecoration(
                                      color: AppColor.mainColor,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Text(
                                      LocaleKeys.categories_apply.tr(),
                                      style: TextStyleTheme.textStyle12Bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          verticalSpace(8),
                          Text(
                            LocaleKeys.cart_all_prices.tr(),
                            style: TextStyleTheme.textStyle13Medium,
                            textAlign: TextAlign.center,
                          ),
                          verticalSpace(12),
                          CustomOrdersMoney(model: bloc.cartData),
                        ],
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: ColoredBox(
                  color: Colors.transparent,
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 16.w,
                        bottom: 20.h,
                        left: 16.w,
                      ),
                      child: SizedBox(
                        width: double.infinity.w,
                        child: AppButton(
                          text: LocaleKeys.cart_move_to_complete_order.tr(),
                          textStyle: TextStyleTheme.textStyle15Bold.copyWith(
                            color: AppColor.white,
                          ),
                          onPressed: () {
                            navigateTo(toPage: const CompleteOrderView());
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}