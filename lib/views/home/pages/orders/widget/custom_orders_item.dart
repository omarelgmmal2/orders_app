import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/logic/helper_methods.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import 'package:vegetable_orders_project/generated/locale_keys.g.dart';
import '../../../../../core/design/custom_app_bar_icon.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../model/all_order_model.dart';
import 'custom_decorated_box.dart';
import 'orders_details_view.dart';

class CustomOrdersItem extends StatefulWidget {
  const CustomOrdersItem({
    super.key,
    this.isDetailsOrder = false,
    this.isFinished = false,
    this.ordersModel,
  });

  final bool isDetailsOrder;
  final bool isFinished;
  final CurrentOrdersModel? ordersModel;

  @override
  State<CustomOrdersItem> createState() => _CustomOrdersItemState();
}

class _CustomOrdersItemState extends State<CustomOrdersItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: GestureDetector(
        onTap: () {
          !widget.isDetailsOrder
              ? widget.isFinished
                    ? navigateTo(
                        toPage: OrderDetailsView(
                          id: widget.ordersModel!.id,
                          ordersModel: widget.ordersModel!,
                          isFinished: true,
                        ),
                      )
                    : navigateTo(
                        toPage: OrderDetailsView(
                          id: widget.ordersModel!.id,
                          ordersModel: widget.ordersModel!,
                          isFinished: false,
                        ),
                      )
              : null;
        },
        child: Container(
          height: 95.h,
          decoration: BoxDecoration(
            color: AppColor.white,
            boxShadow: [
              BoxShadow(blurRadius: 17, color: Colors.black.withOpacity(0.03)),
            ],
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 4.h, start: 14.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${LocaleKeys.orders_order.tr()} #${widget.ordersModel!.id}",
                          style: TextStyleTheme.textStyle17Bold,
                        ),
                        Text(
                          widget.ordersModel!.date,
                          style: TextStyleTheme.textStyle14Light.copyWith(
                            color: Color(0xff9C9C9C),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      end: widget.isDetailsOrder ? 5.w : 9.w,
                      top: widget.isDetailsOrder ? 4.h : 9.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7.r),
                            ),
                            color: !widget.isFinished
                                ? const Color(0xffEDF5E6)
                                : const Color(0xffFFE4E4),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: widget.isDetailsOrder ? 3.h : 4.h,
                            ),
                            child: Text(
                              widget.ordersModel!.status == 'pending'
                                  ? context.locale.languageCode == "en"
                                        ? "Pending"
                                        : 'بإنتظار الموافقة'
                                  : context.locale.languageCode == "en"
                                  ? "Order canceled"
                                  : 'طلب ملغي',
                              style: TextStyle(
                                color: widget.ordersModel!.status == 'pending'
                                    ? AppColor.mainColor
                                    : const Color(0xffFF0000),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        widget.isDetailsOrder
                            ? Padding(
                                padding: EdgeInsets.only(left: 8.w, top: 5.h),
                                child: Text(
                                  '${widget.ordersModel!.totalPrice} ${LocaleKeys.r_s.tr()}',
                                  style: TextStyleTheme.textStyle15Medium,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(height: 5, color: AppColor.mainColor.withOpacity(0.08)),
              verticalSpace(5),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 16, start: 10),
                child: Row(
                  children: [
                    ...List.generate(
                      widget.ordersModel!.products.length > 3
                          ? 3
                          : widget.ordersModel!.products.length,
                      (index) => CustomDecoratedBox(
                        product: widget.ordersModel!.products[index],
                      ),
                    ),
                    widget.ordersModel!.products.length > 3
                        ? CustomDecoratedBox(
                            count: widget.ordersModel!.products.length - 3,
                            isText: true,
                          )
                        : const SizedBox(),
                    const Spacer(),
                    widget.isDetailsOrder
                        ? CustomAppBarIcon(
                            height: 24.h,
                            width: 24.h,
                            isBack: false,
                            color: Color(0xffEDF5E6),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColor.mainColor,
                              size: 16,
                            ),
                          )
                        : Text(
                            '${widget.ordersModel!.totalPrice} ${LocaleKeys.r_s.tr()}',
                            style: TextStyleTheme.textStyle15Bold,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
