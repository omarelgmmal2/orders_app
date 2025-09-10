import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/design/app_button.dart';
import 'package:vegetable_orders_project/core/design/app_input.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/generated/locale_keys.g.dart';
import '../../../../../core/design/custom_app_bar.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/text_style_theme.dart';
import '../../../../../features/my_account/suggestions/suggestions_bloc.dart';

class SuggestionsComplaintsView extends StatefulWidget {
  const SuggestionsComplaintsView({super.key});

  @override
  State<SuggestionsComplaintsView> createState() =>
      _SuggestionsComplaintsViewState();
}

class _SuggestionsComplaintsViewState extends State<SuggestionsComplaintsView> {
  final bloc = KiwiContainer().resolve<SuggestionsBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.my_account_complaints.tr()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            padding: EdgeInsets.only(top: 50.h),
            children: [
              AppInput(
                  controller: bloc.name,
                  isFilled: false,
                  labelText: LocaleKeys.register_user_name.tr(),
                icon: AppImages.user,
              ),
              verticalSpace(10),
              AppInput(
                controller: bloc.phone,
                isFilled: false,
                labelText: LocaleKeys.log_in_phone_number.tr(),
                isPhone: true,
                icon: AppImages.phone,
              ),
              verticalSpace(10),
              AppInput(
                controller: bloc.content,
                isFilled: false,
                labelText: LocaleKeys.contact_us_subject.tr(),
                maxLines: 3,
                icon: AppImages.search,
              ),
              verticalSpace(22),
              BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is SentSuggestionsLoading) {
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
                  }
                  return AppButton(
                      text: LocaleKeys.contact_us_send.tr(),
                    textStyle: TextStyleTheme.textStyle15Bold.copyWith(
                      color: AppColor.white,
                    ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        bloc.add(SendSuggestionsEvent());
                      },
                  );
                },
              ),
              verticalSpace(30),
            ],
          ),
        ),
      ),
    );
  }
}