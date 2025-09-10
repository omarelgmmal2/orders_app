import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import '../../core/design/app_button.dart';
import '../../core/design/app_image.dart';
import '../../core/design/app_input.dart';
import '../../core/design/custom_rich_text.dart';
import '../../core/logic/helper_methods.dart';
import '../../core/utils/app_color.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/spacing.dart';
import '../../core/utils/text_style_theme.dart';
import '../../features/change_password/change_password_bloc.dart';
import '../../generated/locale_keys.g.dart';
import '../login/login_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String phone;
  const ChangePasswordScreen({super.key, required this.phone});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final bloc = KiwiContainer().resolve<ChangePasswordBloc>();

  @override
  void dispose() {
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
                LocaleKeys.forget_password_forget_password.tr(),
                style: TextStyleTheme.textStyle16Bold,
              ),
              verticalSpace(5),
              Text(
                LocaleKeys.reset_password_enter_new_password.tr(),
                style: TextStyleTheme.textStyle16Light,
              ),
              Form(
                key: bloc.formKey,
                child: Column(
                  children: [
                    AppInput(
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      controller: bloc.newPasswordController,
                      focusNode: bloc.newPasswordFocusNode,
                      onFieldSubmitted: (value) {
                        FocusScope.of(
                          context,
                        ).requestFocus(bloc.confirmNewPasswordFocusNode);
                      },
                      isPassword: true,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return LocaleKeys.log_in_please_enter_your_password_again.tr();
                        } else if (value!.length < 6) {
                          return LocaleKeys.log_in_please_enter_six_letters_at_min.tr();
                        }
                        bloc.password = value;
                        return null;
                      },
                      icon: AppImages.unlock,
                      labelText: LocaleKeys.log_in_password.tr(),
                      paddingBottom: 16.h,
                      paddingTop: 17.h,
                    ),
                    AppInput(
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      controller: bloc.confirmNewPasswordController,
                      focusNode: bloc.confirmNewPasswordFocusNode,
                      isPassword: true,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return LocaleKeys.reset_password_please_enter_new_password_again
                              .tr();
                        } else if (value!.length < 6) {
                          return LocaleKeys
                              .reset_password_please_enter_new_password_in_6_letters_at_min
                              .tr();
                        } else if (bloc.newPasswordController.text != value) {
                          return LocaleKeys.change_password_two_passwords_not_matching
                              .tr();
                        } else {
                          return null;
                        }
                      },
                      icon: AppImages.unlock,
                      labelText: LocaleKeys.log_in_password.tr(),
                      paddingBottom: 25.h,
                    ),
                  ],
                ),
              ),
              BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if(state is ResetPasswordLoadingState){
                    return Center(
                      child: CircularProgressIndicator(color: AppColor.mainColor),
                    );
                  }else{
                    return AppButton(
                      text: LocaleKeys.reset_password_change_password.tr(),
                      textStyle: TextStyleTheme.textStyle15Bold.copyWith(
                        color: AppColor.white,
                      ),
                      onPressed: () {
                        if (bloc.formKey.currentState!.validate()) {
                          bloc.add(
                            ResetPasswordEvent(phone: widget.phone),
                          );
                        }
                      },
                    );
                  }
                },
              ),
              verticalSpace(35),
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
    );
  }
}
