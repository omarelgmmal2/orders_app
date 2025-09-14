import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import 'package:vegetable_orders_project/generated/locale_keys.g.dart';
import '../../core/design/app_image.dart';
import '../../core/design/custom_outline_button.dart';
import '../../core/logic/helper_methods.dart';
import '../../features/address/get_delete_address/get_delete_address_bloc.dart';
import '../home/pages/my_account/screens/add_title_view.dart';
import '../home/pages/my_account/widget/custom_title_item.dart';

class TitlesSheet extends StatefulWidget {
  const TitlesSheet({super.key});

  @override
  State<TitlesSheet> createState() => _TitlesSheetState();
}

class _TitlesSheetState extends State<TitlesSheet> {
  final bloc = KiwiContainer().resolve<GetDeleteAddressesBloc>()
    ..add(GetAddressesEvent(isLoading: true));

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.pop(context);
        }
      },
      canPop: false,
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              verticalSpace(10),
              Center(
                child: Text(
                  LocaleKeys.my_account_addresses.tr(),
                  style: TextStyleTheme.textStyle17Bold,
                ),
              ),
              verticalSpace(10),
              Expanded(
                child: BlocBuilder(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is GetAddressesLoadingState) {
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
                           Padding(padding: EdgeInsets.symmetric(horizontal: 70.w),
                            child: AppImage(
                              AppImages.noAddresses,
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
                    }
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.pop(context, bloc.list[index]);
                          },
                          child: CustomTitleItem(model: bloc.list[index]),
                      ),
                      itemCount: bloc.list.length,
                    );
                  },
                ),
              ),
              verticalSpace(10),
              CustomOutlineButton(
                  onPress: () {
                    navigateTo(toPage: const AddTitleView());
                  },
                  title: LocaleKeys.addresses_add_address.tr()),
              verticalSpace(20),
            ],
          ),
        ),
      ),
    );
  }
}