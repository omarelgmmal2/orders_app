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

class TermsView extends StatefulWidget {
  const TermsView({super.key});

  @override
  State<TermsView> createState() => _TermsViewState();
}

class _TermsViewState extends State<TermsView> {
  final bloc = KiwiContainer().resolve<PolicyBloc>()..add(GetTermsEvent());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.my_account_terms.tr()),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is TermsLoadingState) {
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
          } else if (state is TermsSuccessState) {
            var model = parse(state.model.terms);
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