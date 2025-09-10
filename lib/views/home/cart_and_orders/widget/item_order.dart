import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import '../../../../core/design/app_image.dart';
import '../../../../core/design/custom_app_bar_icon.dart';
import '../../../../features/cart/cart_bloc.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/cart_model.dart';
import '../../pages/main/widget/custom_plus_or_minus_product.dart';
import 'custom_show_dialog_item_order.dart';

class ItemOrder extends StatefulWidget {
  final CartModel model;
  final int index;

  const ItemOrder({required this.model, required this.index});

  @override
  State<ItemOrder> createState() => _ItemOrderState();
}

class _ItemOrderState extends State<ItemOrder> {
  final bloc = KiwiContainer().resolve<CartBloc>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 6),
              blurRadius: 17,
              color: const Color(0xff000000).withOpacity(0.02),
            ),
          ],
        ),
        child: SizedBox(
          height: 90.h,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 8.h,
                  right: 6.w,
                  bottom: 8.h,
                  left: 8.w,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  child: AppImage(
                    widget.model.image,
                    height: 78.h,
                    width: 92.w,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.title,
                    style: TextStyleTheme.textStyle16Bold,
                  ),
                  Text(
                    '${widget.model.price} ${LocaleKeys.r_s.tr()}',
                    style: TextStyleTheme.textStyle12Bold.copyWith(
                      color: AppColor.mainColor,
                    ),
                  ),
                  CustomPlusOrMinusProduct(
                    isProductDetails: false,
                    id: widget.model.id,
                    index: widget.index,
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: CustomAppBarIcon(
                  isBack: false,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CustomShowDialogItemOrder(model: widget.model);
                      },
                    );
                  },
                  height: 26.h,
                  width: 26.h,
                  color: const Color(0xffFF0000).withOpacity(0.13),
                  child: BlocBuilder(
                    bloc: bloc,
                    builder: (context, state) {
                      return state is DeleteFromCartLoadingState &&
                              state.id == widget.model.id
                          ? Center(
                              child: SizedBox(
                                height: 15.h,
                                width: 15.h,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: AppColor.red,
                                ),
                              ),
                            )
                          : AppImage(AppImages.trash);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
