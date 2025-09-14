import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/logic/cache_helper.dart';
import '../../../../../core/logic/helper_methods.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/utils/text_style_theme.dart';
import '../../../../../features/address/get_location.dart';
import '../../../../../features/cart/cart_bloc.dart';
import '../../../../../features/my_orders/my_orders_bloc.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../../model/address_model.dart';
import '../../../../sheets/titles_sheet.dart';
import '../../../cart_and_orders/cart_view.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? title;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final Widget? leading;
  final bool? centerTitle;
  final double? toolbarHeight;
  final bool automaticallyImplyLeading;
  final PreferredSizeWidget? bottom;
  final double? elevation;

  const MainAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.toolbarHeight = 60,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.centerTitle,
    this.bottom,
    this.elevation,
  });

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? 60);
}

class _MainAppBarState extends State<MainAppBar> {
  final cartBloc = KiwiContainer().resolve<CartBloc>();
  AddressModel? model;

  @override
  void initState() {
    super.initState();
    cartBloc.add(ShowCartEvent(isLoading: false));
  }

  late int num = CacheHelper.getInCart() ?? 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
        height: 60.h,
        child: Row(
          children: [
            AppImage(AppImages.vegetableBasket, height: 20.h, width: 20.w),
            horizontalSpace(3),
            Text(
              LocaleKeys.home_thamara_basket.tr(),
              style: TextStyleTheme.textStyle14Bold,
            ),
            const Spacer(),
            StreamBuilder<bool>(
              stream: GetLocation.controller.stream,
              builder: (context, snapshot) {
                return SizedBox(
                  width: 160.w,
                  child: GestureDetector(
                    onTap: () async {
                      model = await showModalBottomSheet(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35.r),
                            topRight: Radius.circular(35.r),
                          ),
                        ),
                        context: context,
                        builder: (context) => const TitlesSheet(),
                      );
                      if (model?.location.isNotEmpty ?? false) {
                        final list = model!.location.split(' ');
                        list.removeAt(0);
                        String location = list.join(' ');

                        CacheHelper.setCurrentLocation(location);
                        GetLocation.controller.add(true);
                      }
                      KiwiContainer().resolve<MyOrdersBloc>().addressId = model
                          ?.id
                          .toString();
                    },
                    child: Text.rich(
                      overflow: context.locale.languageCode == 'ar'
                          ? TextOverflow.ellipsis
                          : null,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: LocaleKeys.home_delivery_to.tr(),
                            style: TextStyleTheme.textStyle12Bold.copyWith(
                              color: AppColor.mainColor,
                            ),
                          ),
                          const TextSpan(text: '\n'),
                          TextSpan(
                            text:
                                CacheHelper.getCurrentLocation()?.isEmpty ??
                                    true
                                ? LocaleKeys.home_add_addresses.tr()
                                : CacheHelper.getCurrentLocation(),
                            style: TextStyle(
                              color: AppColor.mainColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            horizontalSpace(context.locale.languageCode == 'ar' ? 20.w : 30.w),
            const Spacer(),
            GestureDetector(
              onTap: () {
                navigateTo(toPage: const CartView());
              },
              child: Badge(
                backgroundColor: AppColor.mainColor,
                offset: context.locale.languageCode == 'ar'
                    ? const Offset(5, -5)
                    : const Offset(-2, -7),
                alignment: AlignmentDirectional.topStart,
                label: BlocListener(
                  bloc: cartBloc,
                  listener: (context, state) {
                    if (state is AddToCartSuccessState ||
                        state is GetCartSuccessState ||
                        state is DeleteFromCartSuccessState) {
                      num = cartBloc.list.length;
                      CacheHelper.setInCart(num);
                    }
                  },
                  child: BlocBuilder(
                    bloc: cartBloc,
                    builder: (context, state) {
                      return Text(
                        "$num",
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                child: Container(
                  height: 33.h,
                  width: 33.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.r),
                    color: AppColor.mainColorOpacity13,
                  ),
                  child: AppImage(AppImages.cart, height: 18.h, width: 16.w),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}