import 'dart:async';
import 'dart:ui' as mat;
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vegetable_orders_project/core/design/app_button.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/features/confirm_code/confirm_code_bloc.dart';
import '../../core/design/app_image.dart';
import '../../core/design/custom_rich_text.dart';
import '../../core/logic/helper_methods.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/spacing.dart';
import '../../core/utils/text_style_theme.dart';
import '../../features/change_password/change_password_bloc.dart';
import '../../generated/locale_keys.g.dart';
import '../login/login_screen.dart';

class ConfirmCodeScreen extends StatefulWidget {
  final bool isActive;
  final String phone;

  const ConfirmCodeScreen({
    super.key,
    required this.isActive,
    required this.phone,
  });

  @override
  State<ConfirmCodeScreen> createState() => _ConfirmCodeScreenState();
}

class _ConfirmCodeScreenState extends State<ConfirmCodeScreen> {
  final bloc = KiwiContainer().resolve<ConfirmCodeBloc>();
  final changePasswordBloc = KiwiContainer().resolve<ChangePasswordBloc>();

  @override
  void initState() {
    if (widget.isActive) {
      Timer(const Duration(seconds: 3), () {
        bloc.confirmCodeController.text = '1111';
        setState(() {});
        bloc.add(
          ConfirmCodeEvent(phone: widget.phone, isActive: widget.isActive),
        );
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        changePasswordBloc.confirmCodeController.text = '1111';
        setState(() {});
        changePasswordBloc.add(CheckCodeEvent(phone: widget.phone));
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    changePasswordBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: bloc.formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            children: [
              AppImage(AppImages.vegetableBasket, height: 126.h, width: 130.w),
              verticalSpace(21),
              Text(
                !widget.isActive
                    ? LocaleKeys.forget_password_forget_password.tr()
                    : LocaleKeys.account_activation_activate_account.tr(),
                style: TextStyleTheme.textStyle16Bold,
              ),
              verticalSpace(5),
              Text(
                LocaleKeys.check_code_enter_the_code_4digits.tr(),
                style: TextStyleTheme.textStyle16Light,
              ),
              Row(
                children: [
                  Text(
                    "+2${widget.phone}",
                    textDirection: mat.TextDirection.ltr,
                    style: TextStyleTheme.textStyle16Light.copyWith(height: .5),
                  ),
                  horizontalSpace(3),
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.zero,
                      ),
                    ),
                    child: Text(
                      LocaleKeys.check_code_change_phone_number.tr(),
                      style: TextStyleTheme.textStyle16Medium.copyWith(
                        height: .5.h,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              AbsorbPointer(
                absorbing: true,
                child: PinCodeTextField(
                  controller: widget.isActive
                      ? bloc.confirmCodeController
                      : changePasswordBloc.confirmCodeController,
                  appContext: context,
                  length: 4,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(15).w,
                    fieldHeight: 50.w,
                    fieldWidth: 60.w,
                    selectedColor: Theme.of(context).primaryColor,
                    inactiveColor: const Color(0xffF3F3F3),
                  ),
                  cursorColor: Theme.of(context).primaryColor,
                  keyboardType: TextInputType.number,
                ),
              ),
              verticalSpace(30),
              widget.isActive
                  ? BlocBuilder(
                      bloc: bloc,
                      builder: (context, state) {
                        return AppButton(
                          text: LocaleKeys.check_code_confirm_the_code.tr(),
                          textStyle: TextStyleTheme.textStyle15Bold.copyWith(
                            color: AppColor.white,
                          ),
                          onPressed: () {
                            bloc.add(
                              ConfirmCodeEvent(
                                phone: widget.phone,
                                isActive: widget.isActive,
                              ),
                            );
                          },
                        );
                      },
                    )
                  : BlocBuilder(
                      bloc: changePasswordBloc,
                      builder: (context, state) {
                        return AppButton(
                          text: LocaleKeys.check_code_confirm_the_code.tr(),
                          textStyle: TextStyleTheme.textStyle15Bold.copyWith(
                            color: AppColor.white,
                          ),
                          onPressed: () {
                            changePasswordBloc.add(
                              CheckCodeEvent(phone: widget.phone),
                            );
                          },
                        );
                      },
                    ),
              verticalSpace(27),
              Text(
                textAlign: TextAlign.center,
                "${LocaleKeys.check_code_didnt_receive_code.tr()} \n${LocaleKeys.check_code_you_can_receive_code_after.tr()}",
                style: TextStyleTheme.textStyle16Light,
              ),
              verticalSpace(21),
              bloc.isTimerFinished
                  ? const SizedBox.shrink()
                  : CircularCountDownTimer(
                      duration: 90,
                      initialDuration: 0,
                      width: 66.w,
                      height: 70.h,
                      ringColor: AppColor.mainColor,
                      fillColor: const Color(0xffD8D8D8),
                      strokeWidth: 3,
                      onComplete: () {
                        bloc.isTimerFinished = true;
                        setState(() {});
                      },
                      textStyle: TextStyleTheme.textStyle21Regular,
                      textFormat: CountdownTextFormat.MM_SS,
                      isReverseAnimation: true,
                    ),
              verticalSpace(19),
              bloc.isTimerFinished
                  ? Center(
                      child: OutlinedButton(
                        onPressed: () {
                          bloc.add(ResendCodeEvent(phone: widget.phone));
                          bloc.isTimerFinished = false;
                          setState(() {});
                        },
                        child: Text(
                          LocaleKeys.check_code_resend.tr(),
                          style: TextStyleTheme.textStyle15Bold,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              verticalSpace(30),
              CustomRichText(
                text: LocaleKeys.forget_password_you_have_an_account.tr(),
                textStyle: TextStyleTheme.textStyle15Bold,
                onTap: () {
                  navigateTo(toPage: LoginScreen());
                },
                subText: LocaleKeys.my_account_log_in.tr(),
                subTextStyle: TextStyleTheme.textStyle18Bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
