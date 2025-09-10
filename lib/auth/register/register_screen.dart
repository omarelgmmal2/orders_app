import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/auth/login/login_screen.dart';
import 'package:vegetable_orders_project/features/register/register_bloc.dart';
import '../../core/design/app_button.dart';
import '../../core/design/app_image.dart';
import '../../core/design/app_input.dart';
import '../../core/design/custom_rich_text.dart';
import '../../core/logic/helper_methods.dart';
import '../../core/utils/app_color.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/spacing.dart';
import '../../core/utils/text_style_theme.dart';
import '../../generated/locale_keys.g.dart';
import '../../views/sheets/cities_sheet.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final bloc = KiwiContainer().resolve<RegisterBloc>();

  @override
  void dispose() {
    bloc.confirmPasswordController.dispose();
    bloc.nameController.dispose();
    bloc.passwordController.dispose();
    bloc.phoneController.dispose();
    bloc.cityController.dispose();
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
              LocaleKeys.register_hello_again.tr(),
              style: TextStyleTheme.textStyle16Bold,
            ),
            verticalSpace(5),
            Text(
              LocaleKeys.register_you_can_register_new_account_now.tr(),
              style: TextStyleTheme.textStyle16Light,
            ),
            Form(
              autovalidateMode: bloc.autoValidateMode,
              key: bloc.formKey,
              child: Column(
                children: [
                  AppInput(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    controller: bloc.nameController,
                    focusNode: bloc.nameFocusNode,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(bloc.phoneFocusNode);
                    },
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return LocaleKeys.register_please_enter_full_name.tr();
                      }
                      return null;
                    },
                    icon: AppImages.user,
                    labelText: LocaleKeys.register_user_name.tr(),
                    paddingTop: 22.h,
                    paddingBottom: 16.h,
                  ),
                  AppInput(
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    controller: bloc.phoneController,
                    focusNode: bloc.phoneFocusNode,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(bloc.cityFocusNode);
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
                    paddingBottom: 16.h,
                  ),
                  StatefulBuilder(
                    builder: (context, setState) => GestureDetector(
                      onTap: () async {
                        var result = await showModalBottomSheet(
                          context: context,
                          builder: (context) => const CitiesSheet(),
                        );
                        if (result != null) {
                          bloc.city = result;
                          setState(() {});
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AbsorbPointer(
                              absorbing: true,
                              child: AppInput(
                                labelText:
                                    bloc.city?.name ??
                                    LocaleKeys.register_city.tr(),
                                focusNode: bloc.cityFocusNode,
                                textInputAction: TextInputAction.next,
                                icon: AppImages.flag,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(bloc.passwordFocusNode);
                                },
                                validator: (value) {
                                  if (bloc.city == null) {
                                    return LocaleKeys
                                        .register_please_enter_your_city
                                        .tr();
                                  }
                                  return null;
                                },
                                paddingBottom: 0.h,
                              ),
                            ),
                          ),
                          if (bloc.city != null)
                            IconButton(
                              onPressed: () {
                                bloc.city = null;
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.clear,
                                size: 24,
                                color: Colors.red,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  AppInput(
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    controller: bloc.passwordController,
                    focusNode: bloc.passwordFocusNode,
                    onFieldSubmitted: (value) {
                      FocusScope.of(
                        context,
                      ).requestFocus(bloc.confirmPasswordFocusNode);
                    },
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
                    paddingBottom: 16.h,
                    paddingTop: 16.h,
                  ),
                  AppInput(
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    controller: bloc.confirmPasswordController,
                    focusNode: bloc.confirmPasswordFocusNode,
                    isPassword: true,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return LocaleKeys
                            .log_in_please_enter_your_password_again
                            .tr();
                      } else if (value!.length < 6) {
                        return LocaleKeys.log_in_please_enter_six_letters_at_min
                            .tr();
                      } else if (value != bloc.passwordController.text) {
                        return LocaleKeys.register_something_wrong.tr();
                      } else {
                        return null;
                      }
                    },
                    icon: AppImages.unlock,
                    labelText: LocaleKeys.log_in_password.tr(),
                    paddingBottom: 24.h,
                  ),
                ],
              ),
            ),
            BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if (state is RegisterLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColor.mainColor),
                  );
                } else {
                  return AppButton(
                    text: LocaleKeys.register_register.tr(),
                    textStyle: TextStyleTheme.textStyle15Bold.copyWith(
                      color: AppColor.white,
                    ),
                    onPressed: () {
                      bloc.add(RegisterEvent());
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
