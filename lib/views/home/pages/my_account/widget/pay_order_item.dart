import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/utils/text_style_theme.dart';
import '../../../../../features/my_account/wallet/wallet_paginated_model.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../../model/cart_model.dart';
import '../../orders/widget/custom_decorated_box.dart';

class PayOrderItem extends StatefulWidget {
  final Data? model;
  final Model? modelPaginated;
  final bool isWallet;

  const PayOrderItem({
    this.model,
    this.modelPaginated,
    required this.isWallet,
  });

  @override
  State<PayOrderItem> createState() => _PayOrderItemState();
}

class _PayOrderItemState extends State<PayOrderItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          Row(
            children: [
              AppImage(
                'assets/icons/account/pay.svg',
                width: 14.w,
              ),
              horizontalSpace(6),
              Flexible(
                flex: 200,
                child: Text(
                  widget.isWallet
                      ? (widget.modelPaginated?.statusTrans ?? "")
                      : "",
                  style: TextStyleTheme.textStyle11SemiBold.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
              ),
              const Spacer(),
            ],
          ),
          verticalSpace(11),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 11,
                  color: Colors.black.withOpacity(0.03),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 13.w, right: 9.w, top: 6.h, bottom: 10.h),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${LocaleKeys.orders_order.tr()} #${!widget.isWallet ? (widget.modelPaginated?.id ?? 0) : 0}",
                          style: TextStyleTheme.textStyle13Bold,
                        ),
                        const Spacer(),
                        Text(
                          widget.isWallet
                              ? (widget.modelPaginated?.date ?? "")
                              : "",
                          style: TextStyleTheme.textStyle12Regular.copyWith(
                            color: const Color(0xff9C9C9C),
                          ),
                        ),
                      ],
                    ),
                    ((!widget.isWallet &&
                        (widget.modelPaginated?.images.isNotEmpty ?? false)) ||
                        (widget.isWallet &&
                            (widget.model?.image.isNotEmpty ?? false)))
                        ? Row(
                      children: [
                        ...List.generate(
                          (widget.isWallet &&
                              (widget.model?.image.length ?? 0) >
                                  3) ||
                              (!widget.isWallet &&
                                  (widget.modelPaginated?.images
                                      .length ??
                                      0) >
                                      3)
                              ? 3
                              : !widget.isWallet
                              ? (widget.modelPaginated?.images.length ??
                              0)
                              : (widget.model?.image.length ?? 0),
                              (index) => CustomDecoratedBox(
                            isWallet: widget.isWallet,
                          ),
                        ),
                        (widget.isWallet &&
                            (widget.model?.image.length ?? 0) >
                                3) ||
                            (!widget.isWallet &&
                                (widget.modelPaginated?.images.length ??
                                    0) >
                                    3)
                            ? CustomDecoratedBox(
                          isWallet: widget.isWallet,
                          count: !widget.isWallet
                              ? (widget.modelPaginated?.images
                              .length ??
                              0) -
                              3
                              : (widget.model?.image.length ?? 0) -
                              3,
                          isText: true,
                        )
                            : const SizedBox(),
                        const Spacer(),
                        Text(
                          '${widget.isWallet ? (widget.model?.amount ?? 0) : (widget.modelPaginated?.amount ?? 0)} ${LocaleKeys.r_s.tr()}',
                          style: TextStyleTheme.textStyle14Medium,
                        ),
                      ],
                    )
                        : Text(
                      '${widget.isWallet ? (widget.model?.amount ?? 0) : (widget.modelPaginated?.amount ?? 0)} ${LocaleKeys.r_s.tr()}',
                      style: TextStyleTheme.textStyle16SemiBold,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
