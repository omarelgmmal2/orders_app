import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/design/app_button.dart';
import 'package:vegetable_orders_project/core/design/app_image.dart';
import 'package:vegetable_orders_project/core/design/app_input.dart';
import 'package:vegetable_orders_project/core/design/custom_text_button.dart';
import 'package:vegetable_orders_project/core/logic/helper_methods.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import 'package:vegetable_orders_project/features/login/login_bloc.dart';
import '../../core/design/custom_rich_text.dart';
import '../../generated/locale_keys.g.dart';
import '../forget_password/forget_password_screen.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bloc = KiwiContainer().resolve<LoginBloc>();

  @override
  void dispose() {
    bloc.passwordController.dispose();
    bloc.phoneController.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          children: [
            AppImage(AppImages.vegetableBasket, height: 126.h, width: 130.w),
            verticalSpace(21),
            Text(
              LocaleKeys.log_in_hello_again.tr(),
              style: TextStyleTheme.textStyle16Bold,
            ),
            verticalSpace(5),
            Text(
              LocaleKeys.log_in_you_can_login_now.tr(),
              style: TextStyleTheme.textStyle16Light,
            ),
            Form(
              autovalidateMode: bloc.autoValidateMode,
              key: bloc.formKey,
              child: Column(
                children: [
                  AppInput(
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    controller: bloc.phoneController,
                    focusNode: bloc.phoneFocusNode,
                    onFieldSubmitted: (value) {
                      FocusScope.of(
                        context,
                      ).requestFocus(bloc.passwordFocusNode);
                    },
                    isPhone: true,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return LocaleKeys.log_in_please_enter_your_mobile_number
                            .tr();
                      } else if (value!.length < 11) {
                        return LocaleKeys.log_in_please_enter_eleven_number
                            .tr();
                      }
                      return null;
                    },
                    icon: AppImages.phone,
                    labelText: LocaleKeys.log_in_phone_number.tr(),
                    paddingTop: 28.h,
                    paddingBottom: 16.h,
                  ),
                  AppInput(
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    controller: bloc.passwordController,
                    focusNode: bloc.passwordFocusNode,
                    isPassword: true,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return LocaleKeys
                            .log_in_please_enter_your_password_again
                            .tr();
                      } else if (value!.length < 6) {
                        return LocaleKeys.log_in_please_enter_six_letters_at_min
                            .tr();
                      }
                      return null;
                    },
                    icon: AppImages.unlock,
                    labelText: LocaleKeys.log_in_password.tr(),
                    paddingBottom: 19.h,
                  ),
                ],
              ),
            ),
            CustomTextButton(
              text: LocaleKeys.log_in_forget_password.tr(),
              onPressed: () {
                navigateTo(toPage: ForgetPasswordScreen());
              },
            ),
            verticalSpace(22),
            BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if (state is LoginLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColor.mainColor),
                  );
                } else {
                  return AppButton(
                    text: LocaleKeys.my_account_log_in.tr(),
                    textStyle: TextStyleTheme.textStyle15Bold.copyWith(
                      color: AppColor.white,
                    ),
                    onPressed: () {
                      bloc.add(LoginEvent());
                    },
                  );
                }
              },
            ),
            verticalSpace(35),
            CustomRichText(
              text: LocaleKeys.log_in_dont_have_an_account.tr(),
              textStyle: TextStyleTheme.textStyle15Bold,
              onTap: () {
                navigateTo(toPage: RegisterScreen());
              },
              subText: LocaleKeys.log_in_register_now.tr(),
              subTextStyle: TextStyleTheme.textStyle18Bold,
            ),
          ],
        ),
      ),
    );
  }
}
