import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_style_theme.dart';
import '../../../../features/cart/cart_bloc.dart';
import '../../../../model/cart_model.dart';

class CustomShowDialogItemOrder extends StatefulWidget {
  final CartModel model;

  const CustomShowDialogItemOrder({super.key, required this.model});

  @override
  State<CustomShowDialogItemOrder> createState() =>
      _CustomShowDialogItemOrderState();
}

class _CustomShowDialogItemOrderState extends State<CustomShowDialogItemOrder> {
  final bloc = KiwiContainer().resolve<CartBloc>();

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      duration: const Duration(milliseconds: 500),
      child: AlertDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 8.h),
        content: const SizedBox.shrink(),
        surfaceTintColor: AppColor.white,
        backgroundColor: AppColor.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        titlePadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
        title: Text(
          "هل انت متاكد من حذف الطلب",
          style: TextStyleTheme.textStyle18Bold,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              backgroundColor: AppColor.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),
            child: Text(
              "حذف",
              style: TextStyleTheme.textStyle13Medium.copyWith(
                color: AppColor.white,
              ),
            ),
            onPressed: () async {
              bloc.add(DeleteProductCartEvent(id: widget.model.id));
            },
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColor.mainColor,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),
            child: Text(
              "الغاء",
              style: TextStyleTheme.textStyle13Medium.copyWith(
                color: AppColor.white,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
