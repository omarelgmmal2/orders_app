import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'core/kiwi.dart';
import 'core/logic/cache_helper.dart';
import 'generated/codegen_loader.g.dart';
import 'orders_app.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColor.mainColor,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  initKiwi();
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          saveLocale: true,
          startLocale: const Locale('ar'),
          path: 'assets/translations',
          assetLoader: const CodegenLoader(),
          fallbackLocale: const Locale('en'),
          child: const OrdersApp(),
      ),
  );
}


