import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import 'package:vegetable_orders_project/views/home/pages/orders/widget/custom_orders_item.dart';
import 'package:vegetable_orders_project/views/home/pages/orders/widget/custom_tab_bar.dart';
import '../../../../core/design/app_image.dart';
import '../../../../core/design/custom_app_bar.dart';
import '../../../../features/my_orders/my_orders_bloc.dart';
import '../../../../generated/locale_keys.g.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  final bloc = KiwiContainer().resolve<MyOrdersBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(GetCurrentOrdersEvent(isLoading: true));
    bloc.add(GetFinishedOrdersEvent(isLoading: true));
  }

  @override
  void dispose() {
    bloc.isLoading = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          height: 120.h,
          thereIsIcon: false,
          title: LocaleKeys.home_nav_my_orders.tr(),
          bottom: const CustomTabBar(),
        ),
        body: TabBarView(
          children: [
            BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if (((state is GetCurrentOrdersLoadingState ||
                        state is GetFinishedOrdersLoadingState) ||
                    bloc.isLoading)) {
                  return ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 24.h,
                    ),
                    itemBuilder: (context, index) => Center(
                      child: CircularProgressIndicator(
                        color: AppColor.mainColor,
                      ),
                    ),
                    itemCount: 6,
                    separatorBuilder: (context, index) => verticalSpace(20),
                  );
                } else if (bloc.currentOrders.isEmpty) {
                  return Center(
                    child: RefreshIndicator(
                      displacement: 20,
                      strokeWidth: 3,
                      backgroundColor: Colors.green[100],
                      onRefresh: () async {
                        bloc.add(GetCurrentOrdersEvent(isLoading: true));
                      },
                      child: ListView(
                        children: [
                          verticalSpace(100),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 70.w),
                            child: AppImage(AppImages.noAddresses),
                          ),
                          verticalSpace(16),
                          Text(
                            LocaleKeys.home_data_not_found.tr(),
                            style: TextStyleTheme.textStyle20Bold,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return RefreshIndicator(
                    displacement: 20,
                    strokeWidth: 3,
                    backgroundColor: Colors.green[100],
                    onRefresh: () async {
                      bloc.add(GetCurrentOrdersEvent(isLoading: true));
                    },
                    child: ListView.builder(
                      physics: bloc.currentOrders.length > 4
                          ? const BouncingScrollPhysics()
                          : const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        vertical: 20.h,
                        horizontal: 16.w,
                      ),
                      itemBuilder: (context, index) => CustomOrdersItem(
                        ordersModel: bloc.currentOrders[index],
                        isFinished: false,
                      ),
                      itemCount: bloc.currentOrders.length,
                    ),
                  );
                }
              },
            ),
            BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if ((state is GetFinishedOrdersLoadingState ||
                        state is GetCurrentOrdersLoadingState ||
                        bloc.isLoading) &&
                    state is! GetFinishedOrdersEmptyState) {
                  return ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 24.h,
                    ),
                    itemBuilder: (context, index) => Center(
                      child: CircularProgressIndicator(
                        color: AppColor.mainColor,
                      ),
                    ),
                    itemCount: 6,
                    separatorBuilder: (context, index) => verticalSpace(20),
                  );
                } else if (bloc.finishedOrders.isEmpty) {
                  return Center(
                    child: RefreshIndicator(
                      displacement: 20,
                      strokeWidth: 3,
                      backgroundColor: Colors.green[100],
                      onRefresh: () async {
                        bloc.add(GetFinishedOrdersEvent(isLoading: true));
                      },
                      child: ListView(
                        children: [
                          verticalSpace(100),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 70.w),
                            child: AppImage(AppImages.noAddresses),
                          ),
                          verticalSpace(16),
                          Text(
                            LocaleKeys.home_data_not_found.tr(),
                            style: TextStyleTheme.textStyle20Bold,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return RefreshIndicator(
                  displacement: 20,
                  strokeWidth: 3,
                  backgroundColor: Colors.green[100],
                  onRefresh: () async {
                    bloc.add(GetFinishedOrdersEvent(isLoading: true));
                  },
                  child: ListView.builder(
                    physics: bloc.finishedOrders.length > 4
                        ? const BouncingScrollPhysics()
                        : const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 16.w,
                    ),
                    itemBuilder: (context, index) => CustomOrdersItem(
                      ordersModel: bloc.finishedOrders[index],
                      isFinished: true,
                    ),
                    itemCount: bloc.finishedOrders.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
