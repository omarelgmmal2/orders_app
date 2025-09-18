import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/design/app_image.dart';
import 'package:vegetable_orders_project/core/design/custom_rich_text.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import 'package:vegetable_orders_project/model/products_model.dart';
import 'package:vegetable_orders_project/views/home/pages/main/widget/product_details_view.dart';
import '../../../../../core/design/app_button.dart';
import '../../../../../core/logic/helper_methods.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../../model/search_model.dart';

class ProductsItem extends StatelessWidget {
  final ProductsModel? model;
  final SearchResult? searchModel;
  final bool isSearch;
  final bool isMainPage;

  const ProductsItem({
    super.key,
    this.model,
    this.searchModel,
    this.isSearch = false,
    this.isMainPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(
            toPage: ProductDetailsView(
              model: model,
              searchModel: searchModel,
            ),
        );
      },
      child: SizedBox(
        width: 163.w,
        child: DecoratedBox(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 11,
              offset: const Offset(0, 2),
            ),
          ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11.r),
            child: ColoredBox(
              color: AppColor.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(11.r),
                          child: AppImage(
                              isSearch ? searchModel!.mainImage : model!.mainImage,
                              fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Container(
                            height: 22.h,
                            width: 54.w,
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                              color: AppColor.mainColor,
                              borderRadius: BorderRadiusDirectional.only(
                                topEnd: Radius.circular(11.r),
                                bottomStart: Radius.circular(11.r),
                              ),
                            ),
                            child: Text(
                              '${isSearch ? searchModel!.discount : model!.discount}%',
                              style: TextStyleTheme.textStyle14Bold.copyWith(
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    isSearch ? searchModel!.title : model!.title,
                      style: TextStyleTheme.textStyle16Bold,
                  ),
                  verticalSpace(4),
                  Text(
                    '${LocaleKeys.price.tr()} / 1 ${isSearch ? searchModel!.unit.name : model!.unit.name}',
                    style: TextStyleTheme.textStyle12Light,
                  ),
                  verticalSpace(3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomRichText(
                        text: "${isSearch ? searchModel!.price : model!.price} ر.س",
                        textStyle: TextStyleTheme.textStyle16Bold,
                        subText: " ${isSearch ? searchModel!.priceBeforeDiscount : model!.priceBeforeDiscount} ر.س",
                        subTextStyle: TextStyleTheme.textStyle13Light.copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Container(
                        height: 23.h,
                        width: 23.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: const Color(0xff61B80C),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.all(0.h),
                          onPressed: () {},
                          icon: Icon(Icons.add, size: 18, color: AppColor.white),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(12),
                  Center(
                    child: AppButton(
                      textStyle: TextStyle(color: AppColor.white),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(110.w, 30.h),
                        backgroundColor: Color(0xff61B80C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.r),
                        ),
                      ),
                      text: LocaleKeys.add_to_cart.tr(),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
