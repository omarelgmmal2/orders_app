import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/features/search_product/search_products_bloc.dart';
import '../../../../../core/design/app_input.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../generated/locale_keys.g.dart';

class SearchAppInput extends StatefulWidget {
  const SearchAppInput({super.key});

  @override
  State<SearchAppInput> createState() => _SearchAppInputState();
}

class _SearchAppInputState extends State<SearchAppInput> {

  final bloc = KiwiContainer().resolve<SearchProductsBloc>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          return AppInput(
            suffixIcon: bloc.textController.text.isNotEmpty
                ? InkWell(
              onTap: () {
                bloc.textController.clear();
                bloc.isNotFound = false;
                bloc.add(SearchProductsEvent(text: ''));
                FocusManager.instance.primaryFocus?.unfocus();
                bloc.search.clear();
              },
              child: Icon(Icons.clear, color: AppColor.mainColor),
            )
                : null,
            onChanged: (value) {
              if (value.isNotEmpty) {
                bloc.add(SearchProductsEvent(text: value));
                if (bloc.search.isEmpty) {
                  bloc.isNotFound = true;
                }
              } else {
                bloc.isNotFound = false;
                bloc.add(SearchProductsEvent(text: value));
                bloc.search.clear();
              }
            },
            controller: bloc.textController,
            labelText: LocaleKeys.home_search_about_you_want.tr(),
            icon: AppImages.search,
            fillColor: const Color(0xff4C8613).withOpacity(.03),
            isFilled: true,
            paddingBottom: 24.h,
            paddingTop: 21.h,
          );
        },
      ),
    );
  }
}
