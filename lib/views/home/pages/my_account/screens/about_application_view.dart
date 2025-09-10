import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/generated/locale_keys.g.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/design/custom_app_bar.dart';
import '../../../../../core/utils/text_style_theme.dart';
import '../../../../../features/my_account/policy_about_terms/policy_about_terms_bloc.dart';

class AboutApplicationView extends StatefulWidget {
  const AboutApplicationView({super.key});

  @override
  State<AboutApplicationView> createState() => _AboutApplicationViewState();
}

class _AboutApplicationViewState extends State<AboutApplicationView> {
  final bloc = KiwiContainer().resolve<PolicyBloc>()..add(GetAboutEvent());
  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.my_account_about_app.tr()),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is AboutLoadingState) {
            return Center(
              child: SizedBox(
                height: 40.h,
                width: 40.h,
                child: CircularProgressIndicator(
                  strokeCap: StrokeCap.round,
                  color: AppColor.mainColor,
                ),
              ),
            );
          } else if (state is AboutSuccessState) {
            var model = parse(state.model.about);
            String text = model.body!.text;
            return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 5.h),
                children: [
                  verticalSpace(5),
                  AppImage(
                    AppImages.vegetableBasket,
                    height: 140.h,
                    width: 142.w,
                  ),
                  verticalSpace(20),
                  Text(
                    text,
                    style: TextStyle(
                        height: 2.1,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 66, 63, 63),
                    ),
                  ),
                  verticalSpace(24),
                ],
              ),
            );
          } else {
            return SizedBox(
              width: double.infinity.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppImage(
                    AppImages.noDataCategory,
                    width: 200.w,
                  ),
                  verticalSpace(8),
                  Text(
                    'لا توجد أسألة',
                    style: TextStyleTheme.textStyle25Bold,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}