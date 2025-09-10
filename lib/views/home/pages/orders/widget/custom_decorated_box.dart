import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../model/all_order_model.dart';
import '../../../../../model/products_model.dart';

class CustomDecoratedBox extends StatelessWidget {
  final bool isText;
  final Products? product;
  final Images? images;
  final Images? imagesPaginated;
  final int? count;
  final bool isWallet;
  const CustomDecoratedBox(
      {super.key,
        this.isText = false,
        this.product,
        this.count,
        this.images,
        this.isWallet = false,
        this.imagesPaginated,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3.w),
      child: SizedBox(
        height: 25.h,
        width: 25.h,
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: !isText
                  ? Border.all(color: const Color(0xff61B80C).withOpacity(0.06))
                  : null,
              borderRadius: BorderRadius.circular(7.r),
              color: const Color(0xffEDF5E6),
          ),
          child: isText
              ? Center(
            child: Text(
              "$count+",
              style: TextStyleTheme.textStyle11Bold,
            ),
          )
              : product != null || images != null || imagesPaginated != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(7.r),
            child: AppImage(
              isWallet
                  ? images!.url
                  : imagesPaginated != null
                  ? imagesPaginated!.url
                  : product!.url,
              height: 20.h,
              width: 20.h,
              fit: BoxFit.cover,
            ),
          )
              : const SizedBox(),
        ),
      ),
    );
  }
}