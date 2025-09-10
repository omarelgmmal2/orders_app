import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/design/app_button.dart';
import 'package:vegetable_orders_project/core/design/app_input.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/generated/locale_keys.g.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/design/custom_app_bar.dart';
import '../../../../../core/utils/text_style_theme.dart';
import '../../../../../features/my_account/contact_us/contact_us_bloc.dart';

class ConnectWithUsView extends StatefulWidget {
  const ConnectWithUsView({super.key});

  @override
  State<ConnectWithUsView> createState() => _ConnectWithUsViewState();
}

class _ConnectWithUsViewState extends State<ConnectWithUsView> {
  final bloc = KiwiContainer().resolve<ContactUsBloc>();

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.my_account_call_us.tr()),
      body: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            children: [
              SizedBox(
                height: 250.h,
                width: double.infinity.w,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(15.r),
                      ),
                      child: AppImage(
                        'assets/icons/account/maps.svg',
                        fit: BoxFit.cover,
                        height: 190.h,
                      ),
                    ),
                    Positioned(
                      top: 47.h,
                      right: 75.w,
                      child: AppImage(
                        'assets/icons/account/mark.svg',
                        height: 25.h,
                      ),
                    ),
                    Positioned(
                      top: 130.h,
                      right: 24.w,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 6),
                              blurRadius: 17,
                              color: Colors.black.withOpacity(0.04),
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.h),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    AppImage(
                                      'assets/icons/account/Location_Calling.svg',
                                      height: 15.h,
                                    ),
                                    horizontalSpace(7),
                                    Text(
                                      'شارع الملك فهد , جدة , المملكة العربية السعودية13',
                                      style: TextStyleTheme.textStyle12Light.copyWith(
                                        color: Color(0xff091022),
                                      ),
                                    ),
                                  ],
                                ),
                                verticalSpace(14),
                                Row(
                                  children: [
                                    AppImage(
                                      'assets/icons/account/Calling.svg',
                                      height: 15.h,
                                    ),
                                    horizontalSpace(7),
                                    Text(
                                      context.locale.languageCode == 'en'
                                          ? '+96605487452'
                                          : '96605487452+',
                                      style: TextStyleTheme.textStyle14Light.copyWith(
                                        color: Color(0xff091022),
                                      ),
                                    ),
                                  ],
                                ),
                                verticalSpace(14),
                                Row(
                                  children: [
                                    AppImage(
                                      'assets/icons/account/Message.svg',
                                      height: 12.h,
                                    ),
                                   horizontalSpace(7),
                                    Text(
                                      'info@thimar.com',
                                      style: TextStyleTheme.textStyle14Light.copyWith(
                                        color: Color(0xff091022),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpace(10),
              Text(
                LocaleKeys.contact_us_or_you_can_send_message.tr(),
                style: TextStyleTheme.textStyle13Bold,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.all(
                          Radius.circular(15.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 17,
                          color: Colors.black.withOpacity(0.04),
                        )
                      ]),
                  child: Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60.h,
                          child: AppInput(
                            controller: bloc.nameController,
                            labelText: LocaleKeys.register_user_name.tr(),
                            isFilled: false,
                            icon: AppImages.user,
                          ),
                        ),
                        verticalSpace(10),
                        SizedBox(
                          height: 60.h,
                          child: AppInput(
                            controller: bloc.phoneController,
                            labelText: LocaleKeys.log_in_phone_number.tr(),
                            isFilled: false,
                            isPhone: true,
                            icon: AppImages.phone,
                          ),
                        ),
                        verticalSpace(10),
                        SizedBox(
                          height: 78.h,
                          child: AppInput(
                            controller: bloc.contentController,
                            labelText: LocaleKeys.contact_us_subject.tr(),
                            isFilled: false,
                            maxLines: 3,
                            icon: AppImages.search,
                          ),
                        ),
                        verticalSpace(16),
                        BlocBuilder(
                          bloc: bloc,
                          builder: (context, state) {
                            if (state is ContactUsLoadingState) {
                              return SizedBox(
                                height: 40.h,
                                width: 40.h,
                                child: CircularProgressIndicator(
                                  color: AppColor.mainColor,
                                ),
                              );
                            }
                            return SizedBox(
                                width: double.infinity,
                                child: AppButton(
                                    text: LocaleKeys.contact_us_send.tr(),
                                  textStyle: TextStyleTheme.textStyle15Bold.copyWith(
                                    color: AppColor.white,
                                  ),
                                  onPressed: () {
                                      FocusScope.of(context).unfocus();

                                      bloc.add(ContactUsEvent());
                                    },
                                ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}