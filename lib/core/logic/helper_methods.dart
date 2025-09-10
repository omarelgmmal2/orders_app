import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future navigateTo({required Widget toPage, bool isRemove = false}) async {
  Navigator.pushAndRemoveUntil(
    navigatorKey.currentContext!,
    MaterialPageRoute(builder: (context) => toPage),
    (route) => !isRemove,
  );
}

enum MessageType { failed, success }

void showMessage({
  String? message,
  MessageType type = MessageType.failed,
  double paddingBottom = 50,
  int duration = 2,
}) {
  if (message!.isNotEmpty) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).removeCurrentSnackBar();
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        duration: Duration(seconds: duration),
        margin: EdgeInsets.only(right: 30.w, left: 30.w, bottom: paddingBottom),
        behavior: SnackBarBehavior.floating,
        backgroundColor: (type == MessageType.success)
            ? AppColor.mainColorOpacity7
            : Colors.redAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
    );
  }
}
