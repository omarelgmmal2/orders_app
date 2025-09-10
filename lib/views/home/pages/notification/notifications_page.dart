import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import 'package:vegetable_orders_project/views/home/pages/notification/widget/item_notifications.dart';
import '../../../../core/design/app_image.dart';
import '../../../../core/design/custom_app_bar.dart';
import '../../../../features/notifications/notifications_bloc.dart';
import '../../../../generated/locale_keys.g.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final bloc = KiwiContainer().resolve<NotificationsBloc>()
    ..add(GetNotificationsEvent());

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  Future<void> refreshCallback() async {
    bloc.add(GetNotificationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        thereIsIcon: false,
        title: LocaleKeys.home_nav_notifications.tr(),
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: state is GetNotificationsLoading || bloc.isLoading
                ? ListView.separated(
                    separatorBuilder: (context, index) => verticalSpace(18),
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 22.h, bottom: 15.h),
                    itemBuilder: (context, index) => Center(
                      child: CircularProgressIndicator(
                        color: AppColor.mainColor,
                      ),
                    ),
                    itemCount: bloc.list.length,
                  )
                : state is GetNotificationsEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppImage(
                            AppImages.notFound,
                            width: 270.w,
                        ),
                        Text(
                          LocaleKeys.home_data_not_found.tr(),
                          style: TextStyleTheme.textStyle25Bold,
                        ),
                        verticalSpace(40),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    displacement: 20,
                    strokeWidth: 3,
                    backgroundColor: Colors.green[100],
                    onRefresh: refreshCallback,
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 22.h, bottom: 15.h),
                      itemBuilder: (context, index) =>
                          ItemNotifications(
                              model: bloc.list[index],
                          ),
                      itemCount: bloc.list.length,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
