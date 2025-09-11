import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/design/app_button.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/generated/locale_keys.g.dart';
import '../../../../../core/design/custom_app_bar.dart';
import '../../../../../core/utils/text_style_theme.dart';
import '../../../../../features/address/set_address/set_address_bloc.dart';
import '../widget/custom_form_input.dart';
import '../widget/custom_google_map.dart';

class AddTitleView extends StatefulWidget {
  final bool isAddTitle;
  final int? id;
  final String? phone;
  final String? description;
  final String? type;
  final double? lat;
  final double? lng;

  const AddTitleView({
    super.key,
    this.isAddTitle = true,
    this.id,
    this.phone,
    this.description,
    this.lat,
    this.lng,
    this.type,
  });

  @override
  State<AddTitleView> createState() => _AddTitleViewState();
}

class _AddTitleViewState extends State<AddTitleView> {
  final bloc = KiwiContainer().resolve<SetUpdateAddressBloc>();
  final phoneController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    !widget.isAddTitle ? phoneController.text = widget.phone! : null;
    !widget.isAddTitle
        ? descriptionController.text = widget.description!
        : null;
    widget.isAddTitle
        ? isHome = true
        : isHome = (widget.type! == 'home') ? true : false;
  }

  bool isHome = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.isAddTitle
            ? LocaleKeys.addresses_add_address.tr()
            : LocaleKeys.addresses,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                SizedBox(
                  height: 300.h,
                  child: CustomGoogleMap(
                    isAddTitle: widget.isAddTitle,
                    lat: widget.lat,
                    lng: widget.lng,
                  ),
                ),
                verticalSpace(12),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: AppColor.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 17,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 14.w,
                        left: 14.w,
                        top: 8.h,
                        bottom: 8.h,
                      ),
                      child: Row(
                        children: [
                          Text(
                            LocaleKeys.addresses_address_type.tr(),
                            style: TextStyleTheme.textStyle15Light.copyWith(
                              color: Color(0xff8B8B8B),
                            ),
                          ),
                          const Spacer(),
                          StatefulBuilder(
                            builder: (context, setState) => Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    isHome = true;
                                    setState(() {});
                                  },
                                  child: _typeOfTitle(
                                    fillColor: isHome
                                        ? AppColor.mainColor
                                        : AppColor.white,
                                    title: LocaleKeys.addresses_home.tr(),
                                    titleColor: isHome
                                        ? AppColor.white
                                        : const Color(0xff8B8B8B),
                                  ),
                                ),
                                horizontalSpace(10),
                                InkWell(
                                  onTap: () {
                                    isHome = false;
                                    setState(() {});
                                  },
                                  child: _typeOfTitle(
                                    fillColor: isHome
                                        ? AppColor.white
                                        : AppColor.mainColor,
                                    title: LocaleKeys.addresses_work.tr(),
                                    titleColor: !isHome
                                        ? AppColor.white
                                        : const Color(0xff8B8B8B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: Form(
                    key: formKey,
                    autovalidateMode: autoValidateMode,
                    child: Column(
                      children: [
                        verticalSpace(14),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.black.withOpacity(0.04),
                                blurRadius: 17,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: CustomFormInput(
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return LocaleKeys
                                    .log_in_please_enter_your_mobile_number
                                    .tr();
                              }
                              return null;
                            },
                            controller: phoneController,
                            labelText: LocaleKeys.log_in_phone_number.tr(),
                            isPhone: true,
                            isTitle: true,
                          ),
                        ),
                        verticalSpace(14),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 17,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15).r,
                          ),
                          child: CustomFormInput(
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return LocaleKeys
                                    .addresses_please_enter_description
                                    .tr();
                              }
                              return null;
                            },
                            controller: descriptionController,
                            labelText: LocaleKeys.addresses_description.tr(),
                            isTitle: true,
                          ),
                        ),
                        verticalSpace(26),
                        BlocBuilder(
                          bloc: bloc,
                          builder: (context, state) {
                            if (state is SetAddressLoadingState ||
                                state is UpdateAddressLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return SizedBox(
                              width: double.infinity,
                              child: AppButton(
                                text: widget.isAddTitle
                                    ? LocaleKeys.addresses_add_address.tr()
                                    : LocaleKeys.addresses_edit_address.tr(),
                                textStyle: TextStyleTheme.textStyle15Bold
                                    .copyWith(color: AppColor.white),
                                onPressed: () {
                                  FocusScope.of(context).unfocus();

                                  if (formKey.currentState!.validate()) {
                                    widget.isAddTitle
                                        ? bloc.add(
                                            SetAddressEvent(
                                              isDefault: "1",
                                              description:
                                                  descriptionController.text,
                                              phone: phoneController.text,
                                              type: isHome ? "1" : "0",
                                            ),
                                          )
                                        : bloc.add(
                                            UpdateAddressEvent(
                                              isDefault: "1",
                                              description:
                                                  descriptionController.text,
                                              phone: phoneController.text,
                                              type: isHome ? "home" : "work",
                                              id: widget.id!,
                                            ),
                                          );
                                  } else {
                                    autoValidateMode =
                                        AutovalidateMode.onUserInteraction;
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _typeOfTitle({
  required Color fillColor,
  required String title,
  required Color titleColor,
}) {
  return DecoratedBox(
    decoration: BoxDecoration(
      border: Border.all(color: AppColor.mainColor.withOpacity(0.5)),
      borderRadius: BorderRadius.circular(9.r),
      color: fillColor,
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    ),
  );
}
