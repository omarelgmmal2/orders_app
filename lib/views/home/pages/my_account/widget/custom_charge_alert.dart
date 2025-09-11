import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/design/app_button.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/generated/locale_keys.g.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/text_style_theme.dart';
import '../../../../../features/my_account/wallet/wallet_bloc.dart';
import 'custom_form_input.dart';

class CustomChargeAlert extends StatefulWidget {
  final WalletBloc bloc;
  const CustomChargeAlert({super.key, required this.bloc});

  @override
  State<CustomChargeAlert> createState() => _CustomChargeAlertState();
}

class _CustomChargeAlertState extends State<CustomChargeAlert> {
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 500),
      child: AlertDialog(
        backgroundColor: AppColor.white,
        title: Center(
          child: Text(
            LocaleKeys.wallet_charge_now.tr(),
            style: TextStyleTheme.textStyle14Bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomFormInput(
              controller: amountController,
              isPhone: true,
              labelText: LocaleKeys.charge_now_your_amount.tr(),
            ),
            verticalSpace(16),
            SizedBox(
              height: 45.h,
              width: double.infinity.w,
              child: BlocBuilder(
                bloc: widget.bloc,
                builder: (context, state) {
                  if (state is WalletChargeLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColor.mainColor,
                      ),
                    );
                  }
                  return AppButton(
                      text: LocaleKeys.categories_apply.tr(),
                      textStyle: TextStyleTheme.textStyle15Bold.copyWith(
                        color: AppColor.white,
                      ),
                      onPressed: () {
                        widget.bloc.add(
                            WalletChargeEvent(amount: amountController.text));
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}