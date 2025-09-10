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
import 'package:vegetable_orders_project/views/home/pages/my_account/screens/add_title_view.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/design/custom_app_bar.dart';
import '../../../../../core/design/custom_outline_button.dart';
import '../../../../../features/address/get_delete_address/get_delete_address_bloc.dart';
import '../widget/custom_title_item.dart';

class TitlesView extends StatefulWidget {
  const TitlesView({super.key});

  @override
  State<TitlesView> createState() => _TitlesViewState();
}

class _TitlesViewState extends State<TitlesView> {
  final bloc = KiwiContainer().resolve<GetDeleteAddressesBloc>();
  @override
  void initState() {
    super.initState();
    bloc.add(GetAddressesEvent(isLoading: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.home_addresses.tr(),
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is GetAddressesLoadingState ) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.mainColor,
              ),
            );
          } else if (bloc.list.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70.w),
                  child: AppImage(
                    AppImages.noDataCategory,
                  ),
                ),
                verticalSpace(16),
                Text(
                  LocaleKeys.home_data_not_found.tr(),
                  style: TextStyleTheme.textStyle20Bold,
                  textAlign: TextAlign.center,
                ),
              ],
            );
          } else {
            return Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 26.h, right: 16.w, left: 16.w),
                    itemBuilder: (context, index) => CustomTitleItem(
                      model: bloc.list[index],
                    ),
                    itemCount: bloc.list.length,
                  ),
                  verticalSpace(10),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h, top: 10.h),
        child: SafeArea(
          child: CustomOutlineButton(
              onPress: () {
                CacheHelper.removeLocation();
                navigateTo(toPage: const AddTitleView());
              },
              title: LocaleKeys.addresses_add_address.tr(),
          ),
        ),
      ),
    );
  }
}