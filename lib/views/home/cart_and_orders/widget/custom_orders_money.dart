import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import 'package:vegetable_orders_project/generated/locale_keys.g.dart';
import '../../../../core/design/app_image.dart';
import '../../../../model/cart_model.dart';
import '../../../../model/order_model.dart';

class CustomOrdersMoney extends StatefulWidget {
  final bool isCompleteOrder;
  final bool isDetailsOrder;
  final CartData? model;
  final OrderModel? orderModel;

  const CustomOrdersMoney({
    super.key,
    this.isCompleteOrder = false,
    this.isDetailsOrder = false,
    this.model,
    this.orderModel,
  });

  @override
  State<CustomOrdersMoney> createState() => _CustomOrdersMoneyState();
}

class _CustomOrdersMoneyState extends State<CustomOrdersMoney> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xffF3F8EE),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 14.w,
          top: 7.h,
          bottom: 10.h,
          right: 7.w,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  LocaleKeys.orders_total_products.tr(),
                  style: TextStyleTheme.textStyle15Medium,
                ),
                const Spacer(),
                Text(
                  "${widget.isDetailsOrder ? widget.orderModel?.priceBeforeDiscount.toString() : widget.model?.totalPriceBeforeDiscount.toString() ?? '00'} ${LocaleKeys.r_s.tr()}",
                  style: TextStyleTheme.textStyle15Medium,
                ),
              ],
            ),
            verticalSpace(3),
            Row(
              children: [
                Text(
                  LocaleKeys.orders_discount.tr(),
                  style: TextStyleTheme.textStyle15Medium,
                ),
                const Spacer(),
                Text(
                  '-${widget.isDetailsOrder ? widget.orderModel?.discount.toString() : widget.model?.totalDiscount.toDouble().toStringAsFixed(2)} ${LocaleKeys.r_s.tr()}',
                  style: TextStyleTheme.textStyle15Medium,
                ),
              ],
            ),
            verticalSpace(5),
            Divider(height: 5.h),
            verticalSpace(5),
            widget.isCompleteOrder || widget.isDetailsOrder
                ? Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            LocaleKeys.orders_total_after_discount.tr(),
                            style: TextStyleTheme.textStyle15Medium,
                          ),
                          const Spacer(),
                          Text(
                            "${widget.isDetailsOrder ? widget.orderModel?.orderPrice.toString() : widget.model?.totalPriceWithVat.toDouble().toStringAsFixed(2) ?? ''} ${LocaleKeys.r_s.tr()}",
                            style: TextStyleTheme.textStyle15Medium,
                          ),
                        ],
                      ),
                      verticalSpace(3),
                      Row(
                        children: [
                          Text(
                            LocaleKeys.orders_delivery_price.tr(),
                            style: TextStyleTheme.textStyle15Medium,
                          ),
                          const Spacer(),
                          Text(
                            "${widget.isDetailsOrder ? widget.orderModel?.deliveryPrice.toString() : widget.model?.deliveryCost.toString() ?? ''} ${LocaleKeys.r_s.tr()}",
                            style: TextStyleTheme.textStyle15Medium,
                          ),
                        ],
                      ),
                      verticalSpace(3),
                      widget.orderModel?.isVip == 1 || widget.model?.isVip == 1
                          ? Row(
                              children: [
                                Text(
                                  LocaleKeys.orders_special_dicount.tr(),
                                  style: TextStyleTheme.textStyle15Medium
                                      .copyWith(color: Colors.orange),
                                ),
                                const Spacer(),
                                Text(
                                  "${widget.isDetailsOrder ? widget.orderModel?.vipDiscount.toString() : widget.model?.vipDiscount.toString() ?? ''} ${LocaleKeys.r_s.tr()}",
                                  style: TextStyleTheme.textStyle15Medium
                                      .copyWith(color: Colors.orange),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      verticalSpace(3),
                      Divider(height: 5.h),
                      verticalSpace(3),
                    ],
                  )
                : const SizedBox(),
            Row(
              children: [
                Text(
                  LocaleKeys.orders_total.tr(),
                  style: TextStyleTheme.textStyle15Medium,
                ),
                const Spacer(),
                Text(
                  '${widget.isDetailsOrder
                      ? widget.orderModel?.totalPrice.toString()
                      : widget.isCompleteOrder
                      ? widget.model?.sum.toDouble().toStringAsFixed(2)
                      : widget.model?.totalPriceWithVat.toDouble().toStringAsFixed(2)} ${LocaleKeys.r_s.tr()}',
                  style: TextStyleTheme.textStyle15Medium,
                ),
              ],
            ),
            widget.isDetailsOrder ? const Divider() : const SizedBox(),
            widget.isDetailsOrder
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.orders_paid_by.tr(),
                        style: TextStyleTheme.textStyle15Medium,
                      ),
                      horizontalSpace(16),
                      AppImage(AppImages.money),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}