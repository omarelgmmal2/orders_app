import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/logic/cache_helper.dart';
import 'package:vegetable_orders_project/core/logic/helper_methods.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import 'package:vegetable_orders_project/generated/locale_keys.g.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/design/custom_app_bar_icon.dart';
import '../../../../../features/address/get_delete_address/get_delete_address_bloc.dart';
import '../../../../../model/address_model.dart';
import '../screens/add_title_view.dart';

class CustomTitleItem extends StatefulWidget {
  const CustomTitleItem({super.key, required this.model});
  final AddressModel model;

  @override
  State<CustomTitleItem> createState() => _CustomTitleItemState();
}

class _CustomTitleItemState extends State<CustomTitleItem> {
  final bloc = KiwiContainer().resolve<GetDeleteAddressesBloc>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 17,
              color: Colors.black.withOpacity(0.03),
            ),
          ],
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: AppColor.mainColor,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(right: 16.w, left: 13.w, bottom: 10.h, top: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.model.type == 'home'
                          ? LocaleKeys.addresses_home.tr()
                          : LocaleKeys.addresses_work.tr(),
                      style: TextStyleTheme.textStyle15Bold,
                    ),
                    Text(
                      '${LocaleKeys.home_address.tr()} : ${widget.model.location}',
                      style: TextStyleTheme.textStyle15Regular,
                    ),
                    Text(
                      '${LocaleKeys.addresses_description.tr()}: ${widget.model.description}',
                      style: TextStyleTheme.textStyle15Light.copyWith(
                        color: Color(0xff999797),
                      ),
                    ),
                    Text(
                      '${LocaleKeys.log_in_phone_number.tr()}: ${widget.model.phone}',
                      style: TextStyleTheme.textStyle15Light.copyWith(
                        color: Color(0xff999797),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  Row(
                    children: [
                      BlocBuilder(
                        bloc: bloc,
                        builder: (context, state) {
                          if (state is DeleteAddressesLoadingState &&
                              state.id == widget.model.id ||
                              state is DeleteAddressesSuccessState &&
                                  state.id == widget.model.id) {
                            return Center(
                              child: SizedBox(
                                  height: 20.h,
                                  width: 20.h,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                              ),
                            );
                          }
                          return CustomAppBarIcon(
                            onTap: () {
                              bloc.add(
                                  DeleteAddressesEvent(id: widget.model.id));
                            },
                            height: 24.h,
                            width: 24.h,
                            isBack: false,
                            color: const Color(0xffFFD4D4),
                            child: AppImage(
                              AppImages.trash,
                            ),
                          );
                        },
                      ),
                      horizontalSpace(10),
                      CustomAppBarIcon(
                        onTap: () {
                          CacheHelper.removeLocation();
                          navigateTo(
                            toPage: AddTitleView(
                              isAddTitle: false,
                              description: widget.model.description,
                              phone: widget.model.phone,
                              type: widget.model.type,
                              lat: widget.model.lat,
                              lng: widget.model.lng,
                              id: widget.model.id,
                            ),
                          );
                        },
                        isBack: false,
                        height: 24.h,
                        width: 24.h,
                        child:
                        const AppImage(
                            'assets/icon/account/Edit2.svg',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}