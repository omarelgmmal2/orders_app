import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/design/app_button.dart';
import 'package:vegetable_orders_project/core/logic/helper_methods.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import 'package:vegetable_orders_project/generated/locale_keys.g.dart';
import 'package:vegetable_orders_project/views/home/pages/orders/widget/product_evaluation_view.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/design/custom_app_bar.dart';
import '../../../../../features/my_orders/my_orders_bloc.dart';
import '../../../../../model/all_order_model.dart';
import '../../../cart_and_orders/widget/custom_orders_money.dart';
import 'custom_orders_item.dart';

class OrderDetailsView extends StatefulWidget {
  const OrderDetailsView({
    super.key,
    this.isFinished = false,
    required this.id,
    required this.ordersModel,
  });
  final bool isFinished;
  final int id;
  final CurrentOrdersModel ordersModel;

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  final bloc = KiwiContainer().resolve<MyOrdersBloc>();
  @override
  void initState() {
    super.initState();
    bloc.add(GetMyOrderEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.orders_order_details.tr(),
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is GetOrderLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.mainColor,
              ),
            );
          } else {
            return ListView(
              padding: EdgeInsets.all(16.h),
              children: [
                CustomOrdersItem(
                  ordersModel: widget.ordersModel,
                  isDetailsOrder: true,
                  isFinished: widget.isFinished ? true : false,
                ),
                verticalSpace(16),
                Text(
                  LocaleKeys.orders_delivery_address.tr(),
                    style: TextStyleTheme.textStyle17Bold,
                ),
                verticalSpace(18),
                DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: AppColor.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 17,
                          color: Colors.black.withOpacity(0.02),
                        )
                      ],
                  ),
                  child: Padding(padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.addresses_home.tr(),
                              style: TextStyleTheme.textStyle15Medium,
                            ),
                            SizedBox(
                              width: 200.w,
                              child: Text(
                                bloc.orderModel?.address?.location ?? '',
                                style: TextStyleTheme.textStyle12Light,
                              ),
                            ),
                            Text(
                              bloc.orderModel?.address?.description ?? '',
                              style: TextStyleTheme.textStyle12Light.copyWith(
                                color: AppColor.black,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(11.r),
                          child: AppImage(
                            'assets/images/google_map.jpg',
                            height: 45.h,
                            width: 55.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpace(16),
                Text(
                    LocaleKeys.orders_order_summary.tr(),
                    style: TextStyleTheme.textStyle17Bold,
                ),
                CustomOrdersMoney(
                  orderModel: bloc.orderModel,
                  isDetailsOrder: true,
                ),
               verticalSpace(30),
              ],
            );
          }
        },
      ),
      extendBody: true,
      bottomNavigationBar: widget.isFinished
          ? ColoredBox(
        color: Colors.transparent,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                right: 16.w, bottom: 20.h, top: 5.h, left: 16.w),
            child: SizedBox(
              width: double.infinity,
              child: AppButton(
                text: context.locale.languageCode == "en"
                    ? "Product Evaluation"
                    : 'تقييم المنتجات',
                textStyle: TextStyleTheme.textStyle15Bold.copyWith(
                  color: AppColor.white,
                ),
                onPressed: () {
                  navigateTo(toPage: const ProductEvaluationView());
                },
              ),
            ),
          ),
        ),
      )
          : Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        child: SizedBox(
          height: 45.h,
          child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is CancelOrderLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xffff0000),
                  ),
                );
              }
              return FilledButton(
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11.r),
                  ),
                  backgroundColor: const Color(0xffFFE1E1),
                ),
                onPressed: () {
                  bloc.add(CancelOrderEvent(id: widget.id));
                },
                child: Text(
                  context.locale.languageCode == "en"
                      ? "Cancel Order"
                      : 'إلغاء الطلب',
                  style: TextStyleTheme.textStyle15Bold.copyWith(
                    color: AppColor.red,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}