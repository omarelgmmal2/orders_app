import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import 'package:vegetable_orders_project/generated/locale_keys.g.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/design/custom_app_bar.dart';
import '../../../../../features/my_account/question/question_bloc.dart';
import '../widget/custom_expansion_tile.dart';

class FrequentlyQuestionsView extends StatefulWidget {
  const FrequentlyQuestionsView({super.key});

  @override
  State<FrequentlyQuestionsView> createState() =>
      _FrequentlyQuestionsViewState();
}

class _FrequentlyQuestionsViewState extends State<FrequentlyQuestionsView> {
  final bloc = KiwiContainer().resolve<QuestionsBloc>()
    ..add(GetQuestionsEvent());
  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.my_account_faqs.tr(),
      ),
      body: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is GetQuestionsLoading) {
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
            } else {
              if (state is GetQuestionsSuccess) {
                return Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: ListView.builder(
                      itemCount: bloc.list.length,
                      itemBuilder: (context, index) => CustomExpansionTile(
                        model: bloc.list[index],
                      ),
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
            }
          },
      ),
    );
  }
}