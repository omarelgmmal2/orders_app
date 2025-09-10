import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/generated/locale_keys.g.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/design/custom_app_bar.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../features/my_account/policy_about_terms/policy_about_terms_bloc.dart';

class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({super.key});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  final bloc = KiwiContainer().resolve<PolicyBloc>()..add(GetPolicyEvent());
  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.my_account_policy.tr()),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is GetPolicyLoading) {
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
          } else if (state is GetPolicySuccess) {
            var model = parse(state.model.policy);
            String text = model.body!.text;
            return Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 16.h),
                children: [
                  verticalSpace(8),
                  Text(
                    text,
                    style: TextStyle(
                        height: 2.1,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 66, 63, 63),
                    ),
                  ),
                  verticalSpace(30),
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
                ],
              ),
            );
          }
        },
      ),
    );
  }
}