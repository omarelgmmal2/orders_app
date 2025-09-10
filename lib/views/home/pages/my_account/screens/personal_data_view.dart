import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/design/app_button.dart';
import 'package:vegetable_orders_project/core/design/app_input.dart';
import 'package:vegetable_orders_project/core/logic/cache_helper.dart';
import 'package:vegetable_orders_project/core/logic/helper_methods.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/features/my_account/edit_profile/edit_profile_bloc.dart';
import 'package:vegetable_orders_project/generated/locale_keys.g.dart';
import 'package:vegetable_orders_project/views/sheets/cities_sheet.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/design/custom_app_bar.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/text_style_theme.dart';
import '../../../../../features/my_account/get_profile/get_profile_bloc.dart';
import '../../../../../model/cities_model.dart';
import '../widget/custom_my_data.dart';
import 'change_password_account.dart';

class PersonalDataView extends StatefulWidget {
  const PersonalDataView({super.key});

  @override
  State<PersonalDataView> createState() => _PersonalDataViewState();
}

class _PersonalDataViewState extends State<PersonalDataView> {
  final bloc = KiwiContainer().resolve<ProfileBloc>();
  final editProfileBloc = KiwiContainer().resolve<EditProfileBloc>();
  CityModel? city;
  @override
  void initState() {
    super.initState();
    bloc.nameController.text = CacheHelper.getUserName() ?? '';
    bloc.phoneController.text = CacheHelper.getUserPhoneEdit() ?? '';
    bloc.cityController.text = CacheHelper.getUserCity() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        editProfileBloc.imagePath = null;
      },
      child: ColoredBox(
        color: Colors.white,
        child: FadeIn(
          duration: const Duration(milliseconds: 500),
          child: Scaffold(
            appBar:
            CustomAppBar(title: LocaleKeys.my_account_personal_data.tr()),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Form(
                key: editProfileBloc.formKey,
                autovalidateMode: editProfileBloc.autoValidateMode,
                child: ListView(
                  padding: EdgeInsets.all(16.h),
                  children: [
                    verticalSpace(10),
                    const CustomMyData(
                      isMain: false,
                    ),
                    verticalSpace(18),
                    AppInput(
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return LocaleKeys.register_please_enter_full_name
                              .tr();
                        }
                        return null;
                      },
                      controller: bloc.nameController,
                      fillColor: const Color(0xffFAFFF5),
                      labelText: LocaleKeys.register_user_name.tr(),
                      icon: 'assets/icons/account/User.svg',
                      paddingBottom: 16.h,
                      paddingTop: 24.h,
                    ),
                    AppInput(
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return LocaleKeys
                              .log_in_please_enter_your_mobile_number
                              .tr();
                        } else if (value!.length < 9) {
                          return LocaleKeys.log_in_please_enter_eleven_number
                              .tr();
                        }
                        return null;
                      },
                      isPhone: true,
                      controller: bloc.phoneController,
                      fillColor: const Color(0xffFAFFF5),
                      labelText: LocaleKeys.log_in_phone_number.tr(),
                      icon: 'assets/icons/account/Phone.svg',
                      paddingBottom: 16.h,
                    ),
                    StatefulBuilder(
                      builder: (context, setState) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                editProfileBloc.city =
                                await showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(28.r),
                                      topRight: Radius.circular(28.r),
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  context: context,
                                  builder: (context) => const CitiesSheet(),
                                );
                                if (editProfileBloc.city != null) {
                                  bloc.cityController.text =
                                      editProfileBloc.city!.name;
                                  setState(() {});
                                }
                              },
                              child: AbsorbPointer(
                                absorbing: true,
                                child: AppInput(
                                  validator: (value) {
                                    if (bloc.cityController.text.isEmpty) {
                                      return LocaleKeys
                                          .register_please_enter_your_city
                                          .tr();
                                    }
                                    return null;
                                  },
                                  controller: bloc.cityController,
                                  fillColor: const Color(0xffFAFFF5),
                                  labelText: LocaleKeys.register_city.tr(),
                                  icon: 'assets/icons/account/Report.svg',
                                ),
                              ),
                            ),
                          ),
                          (bloc.cityController.text.isNotEmpty)
                              ? IconButton(
                            onPressed: () {
                              bloc.cityController.text = '';
                              editProfileBloc.city = null;
                              setState(
                                    () {},
                              );
                            },
                            icon: Icon(
                              Icons.clear,
                              color: Colors.red.shade400,
                            ),
                          )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          navigateTo(toPage: const ChangePasswordAccountView()),
                      child: AppInput(
                        fillColor: const Color(0xffFAFFF5),
                        labelText: LocaleKeys.log_in_password.tr(),
                        icon: 'assets/icons/account/Unlock.svg',
                        paddingTop: 16.h,
                        isPassword: true,
                        paddingBottom: 16.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 16.h),
              child: SafeArea(
                  child: BlocBuilder(
                    bloc: editProfileBloc,
                    builder: (context, state) {
                      if (state is EditProfileDataLoadingState) {
                        return SizedBox(
                          height: 45.h,
                          width: 45.h,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColor.mainColor,
                            ),
                          ),
                        );
                      } else {
                        return AppButton(
                            text: LocaleKeys.profile_edit_data.tr(),
                          textStyle: TextStyleTheme.textStyle15Bold.copyWith(
                            color: AppColor.white,
                          ),
                            onPressed: () {
                              editProfileBloc.add(EditProfileEvent(
                                  fullName: bloc.nameController.text,
                                  phone: bloc.phoneController.text,
                              ),
                              );
                            },
                        );
                      }
                    },
                  ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}