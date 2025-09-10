import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import 'package:vegetable_orders_project/views/home/pages/main/widget/products_item.dart';
import '../../../../core/design/app_image.dart';
import '../../../../core/design/custom_app_bar.dart';
import '../../../../features/products/products_bloc.dart';
import '../../../../generated/locale_keys.g.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final bloc = KiwiContainer().resolve<ProductsBloc>();

  Future<void> refreshCallback() async {
    bloc.add(GetFavsProductsEvent(isLoading: true));
  }

  @override
  void initState() {
    if (bloc.isTransitionFav) {
      bloc.add(GetFavsProductsEvent(isLoading: true));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 500),
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.home_nav_favs.tr(),
          thereIsIcon: false,
        ),
        body: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is GetFavoriteProductLoadingState) {
              return Center(
                child: CircularProgressIndicator(color: AppColor.mainColor),
              );
            } else if (bloc.favsList.isEmpty) {
              return SizedBox(
                width: double.infinity.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppImage(AppImages.noDataFavs, width: 200.w),
                    verticalSpace(8),
                    Text(
                      LocaleKeys.home_data_not_found.tr(),
                      style: TextStyleTheme.textStyle25Bold,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else {
              return RefreshIndicator(
                displacement: 20,
                strokeWidth: 3,
                backgroundColor: Colors.green[100],
                onRefresh: refreshCallback,
                child: GridView.builder(
                  physics: bloc.favsList.length <= 4
                      ? const AlwaysScrollableScrollPhysics()
                      : const BouncingScrollPhysics(),
                  padding: EdgeInsets.all(16.h),
                  itemCount: bloc.favsList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 163 / 265,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) =>
                      ProductsItem(model: bloc.favsList[index]),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
