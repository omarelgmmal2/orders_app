import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/views/home/pages/main/widget/main_app_bar.dart';
import 'package:vegetable_orders_project/views/home/pages/main/widget/custom_carousel_slider.dart';
import 'package:vegetable_orders_project/views/home/pages/main/widget/custom_categories.dart';
import 'package:vegetable_orders_project/views/home/pages/main/widget/custom_products.dart';
import 'package:vegetable_orders_project/views/home/pages/main/widget/custom_section_text.dart';
import 'package:vegetable_orders_project/views/home/pages/main/widget/search_app_input.dart';
import '../../../../generated/locale_keys.g.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SearchAppInput(),
          CustomCarouselSlider(),
          verticalSpace(29),
          CustomSectionText(text: LocaleKeys.home_categories.tr()),
          CustomCategories(),
          verticalSpace(28),
          CustomSectionText(text: LocaleKeys.home_items.tr()),
          verticalSpace(7),
          CustomProducts(),
        ],
      ),
    );
  }
}
