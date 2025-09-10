import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/auth/login/login_screen.dart';
import 'package:vegetable_orders_project/core/design/app_image.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import '../core/logic/cache_helper.dart';
import '../core/logic/helper_methods.dart';
import '../views/home/home_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() async {
    Timer(const Duration(milliseconds: 2000), () {
      navigateTo(
        isRemove: true,
        toPage: CacheHelper.isAuth() ? const HomeView() : const LoginScreen(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          Positioned.directional(
              textDirection: TextDirection.ltr,
              bottom: -53.h,
              start: 80.w,
              child: AppImage(
                AppImages.splash_ib,
                width: 448.w,
                height: 298.h,
              ),
          ),
          AppImage(
            AppImages.splash_bg,
            width: double.infinity.w,
            height: double.infinity.h,
            fit: BoxFit.fill,
          ),
          Center(
            child: FlipInY(
              delay: const Duration(milliseconds: 700),
              duration: const Duration(milliseconds: 1500),
              child: ZoomIn(
                delay: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 750),
                child: AppImage(
                  AppImages.vegetableBasket,
                  width: 160.w,
                  height: 157.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
