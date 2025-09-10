import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/design/app_input.dart';
import 'package:vegetable_orders_project/core/design/custom_app_bar.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import 'package:vegetable_orders_project/model/get_categories_model.dart';
import 'package:vegetable_orders_project/views/home/pages/main/widget/products_item.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../features/search_category/search_category_bloc.dart';
import '../../../../../generated/locale_keys.g.dart';

class CategoryView extends StatefulWidget {
  final int id;
  final GetCategoriesModel model;

  const CategoryView({super.key, required this.id, required this.model});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final getSearchBloc = KiwiContainer().resolve<GetSearchCategoryBloc>();
  bool isNotFound = false;

  @override
  void initState() {
    super.initState();
    getSearchBloc.add(GetSearchCategoryEvent(id: widget.id));
  }

  @override
  void dispose() {
    super.dispose();
    getSearchBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: CustomAppBar(title: widget.model.name),
      body: Column(
        children: [
          verticalSpace(20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: AppInput(
              controller: getSearchBloc.textController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  getSearchBloc.add(
                    GetSearchCategoryEvent(id: widget.id, value: value),
                  );
                  if (getSearchBloc.search.isEmpty) {
                    isNotFound = true;
                  }
                } else {
                  isNotFound = false;
                  getSearchBloc.add(
                    GetSearchCategoryEvent(id: widget.id, value: value),
                  );
                  getSearchBloc.search.clear();
                }
              },
              labelText: LocaleKeys.home_search_about_you_want.tr(),
              icon: AppImages.search,
              fillColor: const Color(0xff4C8613).withOpacity(.03),
              paddingBottom: 20.h,
            ),
          ),
          Expanded(
            child: BlocBuilder(
              bloc: getSearchBloc,
              builder: (context, state) {
                if (state is GetSearchCategoryLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColor.mainColor),
                  );
                } else if (getSearchBloc.search.isEmpty) {
                  return SizedBox(
                    width: double.infinity.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppImage(AppImages.noDataCategory, width: 200.w),
                        verticalSpace(8),
                        Text(
                          LocaleKeys.home_data_not_found.tr(),
                          style: TextStyleTheme.textStyle25Bold,
                          textAlign: TextAlign.center,
                        ),
                        verticalSpace(80),
                      ],
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: RefreshIndicator(
                      displacement: 20,
                      strokeWidth: 3,
                      backgroundColor: Colors.green[100],
                      onRefresh: () async {
                        getSearchBloc.add(
                          GetSearchCategoryEvent(id: widget.id),
                        );
                      },
                      child: GridView.builder(
                        physics: getSearchBloc.search.length > 4
                            ? const BouncingScrollPhysics()
                            : const AlwaysScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 163 / 215,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                        padding: EdgeInsets.only(
                          right: 16.w,
                          left: 16.w,
                          top: 10.h,
                          bottom: 20.h,
                        ),
                        itemCount: getSearchBloc.search.length,
                        itemBuilder: (BuildContext context, int index) =>
                            ProductsItem(
                              isSearch: true,
                              searchModel: getSearchBloc.search[index],
                            ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
