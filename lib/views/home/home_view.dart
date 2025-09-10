import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/design/app_image.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import 'package:vegetable_orders_project/views/home/pages/favourite/favs_page.dart';
import 'package:vegetable_orders_project/views/home/pages/main/main_page.dart';
import 'package:vegetable_orders_project/views/home/pages/my_account/my_account_page.dart';
import 'package:vegetable_orders_project/views/home/pages/notification/notifications_page.dart';
import 'package:vegetable_orders_project/views/home/pages/orders/my_orders_page.dart';
import '../../generated/locale_keys.g.dart';

class HomeView extends StatefulWidget {
  final bool isNavigateToOrder;
  const HomeView({super.key,this.isNavigateToOrder = false});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int currentIndex = 0;

  List<Widget> pages = [
    const MainPage(),
    const MyOrdersPage(),
    const NotificationsPage(),
    const FavouritePage(),
    const MyAccountPage(),
  ];

  List<String> titles = [
    LocaleKeys.home_nav_main_page.tr(),
    LocaleKeys.home_nav_my_orders.tr(),
    LocaleKeys.home_nav_notifications.tr(),
    LocaleKeys.home_nav_favs.tr(),
    LocaleKeys.home_nav_my_account.tr(),
  ];

  List<String> icons = [
    AppImages.main,
    AppImages.orders,
    AppImages.notification,
    AppImages.favourite,
    AppImages.user,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          child: SizedBox(
            height: 60.h,
            child: BottomNavigationBar(
              unselectedLabelStyle: TextStyle(fontSize: 10.sp),
              selectedLabelStyle: TextStyle(fontSize: 12.sp),
              backgroundColor: AppColor.mainColor,
              unselectedItemColor: const Color(0xffAED489),
              selectedItemColor: AppColor.white,
                currentIndex: currentIndex,
                type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                items: List.generate(
                  pages.length,
                      (index) => BottomNavigationBarItem(
                    icon: AppImage(
                      icons[index],
                      color: currentIndex == index
                          ? Colors.white
                          : const Color(0xffAED489),
                    ),
                    label: titles[index],
                  ),
                ),
            ),
          ),
        ),
      ),
    );
  }
}
