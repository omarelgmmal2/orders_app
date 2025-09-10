import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/design/app_button.dart';
import 'package:vegetable_orders_project/core/design/app_input.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import '../../core/utils/app_color.dart';
import '../../core/utils/text_style_theme.dart';

class AddCardSheet extends StatelessWidget {
  const AddCardSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity.h,
      child: ListView(
        padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 26.h, top: 16.h),
        children: [
          Text(
            'إضافة بطاقة',
            style: TextStyleTheme.textStyle15Bold,
            textAlign: TextAlign.center,
          ),
          verticalSpace(16),
          const AppInput(
              isFilled: false,
              labelText: 'اسم صاحب البطاقة',
          ),
          verticalSpace(16),
          const AppInput(
            isFilled: false,
            labelText: 'رقم البطاقة',
            isPhone: true,
          ),
          verticalSpace(16),
          Row(
            children: [
              const Expanded(
                  child: AppInput(
                    isFilled: false,
                    labelText: 'تاريخ الإنتهاء (شهر / سنة)',
                    isPhone: true,
                  ),
              ),
              horizontalSpace(16),
              const Expanded(
                  child: AppInput(
                    isFilled: false,
                    labelText: '(Cvv) الرقم السري ',
                    isPhone: true,
                  ),
              ),
            ],
          ),
          verticalSpace(40),
          AppButton(
              text: 'إضافة بطاقة',
            textStyle: TextStyleTheme.textStyle15Bold.copyWith(
              color: AppColor.white,
            ),
              onPressed: () {},
          ),
          verticalSpace(250),
        ],
      ),
    );
  }
}