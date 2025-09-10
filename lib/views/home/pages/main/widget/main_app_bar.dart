import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/design/custom_rich_text.dart';
import '../../../../../core/logic/cache_helper.dart';
import '../../../../../core/logic/helper_methods.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/utils/text_style_theme.dart';
import '../../../../../features/cart/cart_bloc.dart';
import '../../../../../generated/locale_keys.g.dart';
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
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            AppImage(AppImages.vegetableBasket, height: 20.h, width: 20.w),
            horizontalSpace(3),
            Text(
              LocaleKeys.home_thamara_basket.tr(),
              style: TextStyleTheme.textStyle14Bold,
            ),
            const Spacer(),
            CustomRichText(
              text: LocaleKeys.home_delivery_to.tr(),
              textStyle: TextStyleTheme.textStyle12Medium,
              subText: LocaleKeys.home_address.tr(),
              subTextStyle: TextStyleTheme.textStyle14Regular,
              slash: "\n",
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
