import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/design/app_button.dart';
import 'package:vegetable_orders_project/core/design/app_input.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import '../../../../../core/design/custom_app_bar.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/text_style_theme.dart';

class WalletChargeNowView extends StatelessWidget {
  const WalletChargeNowView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'شحن الان'),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          children: [
            verticalSpace(56),
            Text(
              'معلومات المبلغ',
              style: TextStyleTheme.textStyle15Bold,
            ),
            verticalSpace(18),
            const AppInput(
              labelText: 'المبلغ الخاص بك',
              isPhone: true,
            ),
            verticalSpace(38),
            Text(
              'معلومات البطاقة',
              style: TextStyleTheme.textStyle15Bold,
            ),
            verticalSpace(18),
            const AppInput(labelText: 'الاسم'),
            verticalSpace(18),
            const AppInput(
              labelText: 'رقم البطاقة الائتمانية',
              isPhone: true,
            ),
            verticalSpace(18),
            Row(
              children: [
                Expanded(
                  child: AppInput(
                    labelText: 'تاريخ الانتهاء',
                    isPhone: true,
                  ),
                ),
                horizontalSpace(18),
                Expanded(
                  child: AppInput(
                    labelText: 'الرقم المتسلسل',
                    isPhone: true,
                  ),
                ),
              ],
            ),
            verticalSpace(26),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 24.h),
        child: SafeArea(
          child: AppButton(
            text:  'دفع الآن',
            textStyle: TextStyleTheme.textStyle15Bold.copyWith(
              color: AppColor.white,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}