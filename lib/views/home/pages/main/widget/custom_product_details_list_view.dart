import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/design/custom_rich_text.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/utils/text_style_theme.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../../model/products_model.dart';
import '../../../../../model/search_model.dart';
import 'custom_list_similar_products.dart';
import 'custom_plus_or_minus_product.dart';
import 'custom_product_rate_item.dart';

class CustomProductDetailsListView extends StatelessWidget {
  final ProductsModel? model;
  final SearchResult? searchModel;

  const CustomProductDetailsListView({super.key, this.model, this.searchModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.r),
            bottomRight: Radius.circular(25.r),
          ),
          child: AppImage(
            model?.mainImage ?? searchModel!.mainImage,
            width: double.infinity,
            height: 250.h,
            fit: BoxFit.cover,
          ),
        ),
        verticalSpace(14),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Text(
                model?.title ?? searchModel!.title,
                style: TextStyleTheme.textStyle22Bold,
              ),
              Spacer(),
              Text(
                "${model?.discount ?? searchModel!.discount}%",
                style: TextStyleTheme.textStyle13Light.copyWith(
                  color: AppColor.red,
                ),
              ),
              horizontalSpace(8),
              Text(
                '${model?.price ?? searchModel!.price}${LocaleKeys.r_s.tr()}',
                style: TextStyleTheme.textStyle18Bold,
              ),
              horizontalSpace(3),
              Text(
                '${model?.priceBeforeDiscount ?? searchModel!.priceBeforeDiscount}${LocaleKeys.r_s.tr()}',
                style: TextStyleTheme.textStyle13Light.copyWith(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ),
        verticalSpace(4),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Text(
                '${LocaleKeys.price.tr()} / 1 ${model?.unit.name ?? searchModel!.unit.name}',
                style: TextStyleTheme.textStyle19Light,
              ),
              Spacer(),
              CustomPlusOrMinusProduct(
                id: model?.id ?? searchModel!.id,
                index: 1,
              ),
            ],
          ),
        ),
        verticalSpace(34),
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: CustomRichText(
            textAlign: TextAlign.start,
            text: "${LocaleKeys.product_details_product_code.tr()} ",
            textStyle: TextStyleTheme.textStyle17Bold,
            subText:
                "  ${model?.id.toString() ?? searchModel!.id.toString()} #",
            subTextStyle: TextStyleTheme.textStyle19Light,
          ),
        ),
        verticalSpace(40),
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: Text(
            LocaleKeys.product_details_product_details.tr(),
            style: TextStyleTheme.textStyle17Bold,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: ReadMoreText(
            model?.description ?? searchModel!.description,
            trimLines: 3,
            trimMode: TrimMode.Line,
            trimCollapsedText: "عرض المزيد",
            trimExpandedText: "عرض الاقل",
            style: TextStyleTheme.textStyle14Light,
            moreStyle: TextStyleTheme.textStyle15Medium,
            lessStyle: TextStyleTheme.textStyle15Medium,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            LocaleKeys.product_details_ratings.tr(),
            style: TextStyleTheme.textStyle17Bold,
          ),
        ),
        verticalSpace(12),
        CustomProductRateItem(id: model?.categoryId ?? searchModel!.categoryId),
        verticalSpace(16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            LocaleKeys.product_details_similar_products.tr(),
            style: TextStyleTheme.textStyle17Bold,
          ),
        ),
        verticalSpace(16),
        CustomListSimilarProducts(
          id: model?.categoryId ?? searchModel!.categoryId,
        ),
        verticalSpace(20),
      ],
    );
  }
}