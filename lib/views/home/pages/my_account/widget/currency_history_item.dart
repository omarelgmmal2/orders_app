import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/views/home/pages/my_account/widget/pay_order_item.dart';
import 'package:vegetable_orders_project/views/home/pages/my_account/widget/wallet_charge_item.dart';
import '../../../../../features/my_account/wallet/wallet_paginated_model.dart';
import '../../../../../model/cart_model.dart';

class CurrencyHistoryItem extends StatefulWidget {
  final bool isCharge;
  final Data? model;
  final Model? modelPaginated;
  final bool isWallet;

  const CurrencyHistoryItem({
    super.key,
        required this.isCharge,
         this.model,
        this.modelPaginated,
        required this.isWallet,
  });


  @override
  State<CurrencyHistoryItem> createState() => _CurrencyHistoryItemState();
}

class _CurrencyHistoryItemState extends State<CurrencyHistoryItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h, right: 15.w, left: 15.w),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: AppColor.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 11,
                  color: Colors.black.withOpacity(0.03),
              ),
            ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 11.h),
          child: widget.isCharge
              ? const WalletChargeItem()
              : PayOrderItem(
            isWallet: widget.isWallet,
            modelPaginated: widget.modelPaginated,
            model: widget.model,
          ),
        ),
      ),
    );
  }
}