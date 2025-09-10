import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/utils/text_style_theme.dart';

class WalletChargeItem extends StatelessWidget {
  const WalletChargeItem();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppImage('assets/icon/account/charge.svg'),
          horizontalSpace(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('شحن المحفظة', style: TextStyleTheme.textStyle15Bold),
              verticalSpace(5),
              Text('255 ر.س', style: TextStyleTheme.textStyle15Bold),
            ],
          ),
          Spacer(),
          Text(
            "27,يونيو,2021",
            style: TextStyleTheme.textStyle14Light.copyWith(
              color: Color((0xff9C9C9C)),
            ),
          ),
        ],
      ),
    );
  }
}
