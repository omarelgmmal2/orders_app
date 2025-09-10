import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';

import '../../../../../core/design/app_image.dart';
import '../../../../../core/design/custom_app_bar.dart';
import '../../../../../core/design/custom_outline_button.dart';
import '../../../../sheets/add_card_sheet.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  bool isBlackCheck = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الدفع'),
      body: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
            children: [
              Stack(
                children: [
                  const AppImage(
                    'assets/images/black_visa.png',
                  ),
                  Positioned(
                    top: -6.h,
                    right: -6.w,
                    child: Checkbox(
                      side: BorderSide(color: AppColor.white, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      fillColor: MaterialStatePropertyAll(AppColor.white),
                      checkColor: AppColor.mainColor,
                      value: isBlackCheck,
                      onChanged: (value) {
                        setState(() {
                          isBlackCheck = true;
                          value = true;
                        });
                      },
                    ),
                  ),
                  Positioned(
                    top: 11.h,
                    right: 45.w,
                    child: AppImage(
                      AppImages.trash,
                      color: AppColor.white,
                    ),
                  ),
                ],
              ),
              verticalSpace(20),
              Stack(
                children: [
                  const AppImage(
                    'assets/images/green_visa.png',
                  ),
                  Positioned(
                    top: -6.h,
                    right: -6.w,
                    child: Checkbox(
                      checkColor: AppColor.mainColor,
                      side: BorderSide(color: AppColor.white, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      fillColor: MaterialStatePropertyAll(AppColor.white),
                      value: !isBlackCheck,
                      onChanged: (value) {
                        isBlackCheck = false;
                        setState(() {});
                      },
                    ),
                  ),
                  Positioned(
                      top: 11.h,
                      right: 45.w,
                      child: AppImage(
                        AppImages.trash,
                        color: AppColor.white,
                      ),
                  ),
                ],
              ),
              verticalSpace(22),
              CustomOutlineButton(
                onPress: () {
                  showModalBottomSheet(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28.r),
                        topRight: Radius.circular(28.r),
                      ),
                    ),
                    context: context,
                    builder: (context) => const AddCardSheet(),
                  );
                },
                title: 'إضافة بطاقة',
              ),
            ],
        ),
      ),
    );
  }
}