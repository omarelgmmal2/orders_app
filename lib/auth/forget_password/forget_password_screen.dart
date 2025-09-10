import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/features/forget_password/forget_password_bloc.dart';
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
import '../login/login_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  final bloc = KiwiContainer().resolve<ForgetPasswordBloc>();

  @override
  void dispose() {
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
              LocaleKeys.forget_password_forget_password.tr(),
              style: TextStyleTheme.textStyle16Bold,
            ),
            verticalSpace(5),
            Text(
              LocaleKeys.forget_password_enter_your_phone_number.tr(),
              style: TextStyleTheme.textStyle16Light,
            ),
            Form(
              key: bloc.formKey,
              autovalidateMode: bloc.autoValidateMode,
              child: Column(
                children: [
                  AppInput(
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    controller: bloc.phoneController,
                    focusNode: bloc.phoneFocusNode,
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
                    paddingBottom: 24.h,
                  ),
                ],
              ),
            ),
            BlocBuilder(
              bloc: bloc,
                builder: (context, state) {
                  if(state is ForgetPasswordLoadingState){
                    return Center(
                      child: CircularProgressIndicator(color: AppColor.mainColor),
                    );
                  }else{
                    return AppButton(
                      text: LocaleKeys.forget_password_confirm_phone_number.tr(),
                      textStyle: TextStyleTheme.textStyle15Bold.copyWith(
                        color: AppColor.white,
                      ),
                      onPressed: () {
                        bloc.add(
                            ForgetPasswordEvent(
                                phone: bloc.phoneController.text,
                            ),
                        );
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
