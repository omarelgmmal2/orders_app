import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/design/app_button.dart';
import 'package:vegetable_orders_project/core/design/app_input.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/generated/locale_keys.g.dart';
import '../../../../../core/design/custom_app_bar.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/text_style_theme.dart';
import '../../../../../features/my_account/edit_password/edit_password_bloc.dart';

class ChangePasswordAccountView extends StatefulWidget {
  const ChangePasswordAccountView({super.key});

  @override
  State<ChangePasswordAccountView> createState() =>
      _ChangePasswordAccountViewState();
}

class _ChangePasswordAccountViewState extends State<ChangePasswordAccountView> {
  final bloc = KiwiContainer().resolve<EditPasswordBloc>();
  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        bloc.confirmNewPassword.clear();
        bloc.newPassword.clear();
        bloc.oldPassword.clear();
      },
      child: ColoredBox(
        color: Colors.white,
        child: FadeIn(
          duration: const Duration(milliseconds: 500),
          child: Scaffold(
              appBar: CustomAppBar(
                  title: LocaleKeys.reset_password_change_password.tr()),
              body: GestureDetector(
                onTap: () {
                  if (FocusScope.of(context).hasFocus) {
                    FocusScope.of(context).unfocus();
                  }
                },
                child: Form(
                  key: bloc.formKey,
                  autovalidateMode: bloc.autoValidateMode,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    children: [
                      verticalSpace(20),
                      AppInput(
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return LocaleKeys
                                .reset_password_please_enter_new_password_again
                                .tr();
                          }
                          return null;
                        },
                        controller: bloc.oldPassword,
                        isPassword: true,
                        fillColor: const Color(0xffFAFFF5),
                        labelText:
                        LocaleKeys.reset_password_current_password.tr(),
                        icon: 'assets/icons/account/Unlock.svg',
                      ),
                      AppInput(
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return LocaleKeys
                                .reset_password_please_enter_new_password_in_6_letters_at_min
                                .tr();
                          }
                          return null;
                        },
                        controller: bloc.newPassword,
                        isPassword: true,
                        fillColor: const Color(0xffFAFFF5),
                        labelText: LocaleKeys.reset_password_new_password.tr(),
                        icon: 'assets/icons/account/Unlock.svg',
                      ),
                      AppInput(
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return LocaleKeys
                                .reset_password_please_enter_new_password_again
                                .tr();
                          }
                          return null;
                        },
                        controller: bloc.confirmNewPassword,
                        isPassword: true,
                        fillColor: const Color(0xffFAFFF5),
                        labelText:
                        LocaleKeys.reset_password_confirm_new_password.tr(),
                        icon: 'assets/icons/account/Unlock.svg',
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is EditPasswordLoading) {
                    return Padding(
                      padding: EdgeInsets.all(26.h),
                      child: SizedBox(
                        height: 40.h,
                        width: 40.h,
                        child: Center(
                            child: CircularProgressIndicator(
                              color: AppColor.mainColor,
                            ),
                        ),
                      ),
                    );
                  }
                  return SafeArea(
                    child: Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 20.h),
                        child: SizedBox(
                          width: double.infinity.w,
                          child: AppButton(
                            text:
                            LocaleKeys.reset_password_change_password.tr(),
                            textStyle: TextStyleTheme.textStyle15Bold.copyWith(
                              color: AppColor.white,
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              bloc.add(EditPasswordEvent());
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
          ),
        ),
      ),
    );
  }
}