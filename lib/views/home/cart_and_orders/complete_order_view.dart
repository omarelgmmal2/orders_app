import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/design/app_button.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/views/home/cart_and_orders/widget/custom_orders_money.dart';
import '../../../core/design/app_image.dart';
import '../../../core/design/custom_app_bar.dart';
import '../../../core/design/custom_app_bar_icon.dart';
import '../../../core/logic/cache_helper.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../core/utils/text_style_theme.dart';
import '../../../features/address/get_location.dart';
import '../../../features/cart/cart_bloc.dart';
import '../../../features/my_orders/my_orders_bloc.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../model/address_model.dart';
import '../../sheets/titles_sheet.dart';
import '../pages/my_account/screens/add_title_view.dart';

class CompleteOrderView extends StatefulWidget {
  const CompleteOrderView({super.key});

  @override
  State<CompleteOrderView> createState() => _CompleteOrderViewState();
}

class _CompleteOrderViewState extends State<CompleteOrderView> {

  final bloc = KiwiContainer().resolve<MyOrdersBloc>();

  AddressModel? model;
  bool isKash = true;
  bool isCards = false;
  bool isWallet = false;
  DateTime? datePicker;
  TimeOfDay? timePicker;
  String? time;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: FadeIn(
        duration: const Duration(milliseconds: 500),
        child: Scaffold(
          appBar: CustomAppBar(
            title: LocaleKeys.complete_order_complete_order.tr(),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(
              child: ListView(
                padding: EdgeInsets.all(16.h),
                children: [
                  Text(
                    '${LocaleKeys.charge_now_name.tr()} : ${CacheHelper.getUserName()}',
                    style: TextStyleTheme.textStyle14Bold,
                  ),
                  verticalSpace(10),
                  Text(
                    '${LocaleKeys.complete_order_phone.tr()} : ${CacheHelper.getUserPhone()}',
                    style: TextStyleTheme.textStyle14Bold,
                  ),
                  verticalSpace(34),
                  Row(
                    children: [
                      Text(
                        LocaleKeys.complete_order_choose_the_delivery_address
                            .tr(),
                        style: TextStyleTheme.textStyle14Bold,
                      ),
                      const Spacer(),
                      CustomAppBarIcon(
                        onTap: () => navigateTo(toPage: const AddTitleView()),
                        isBack: false,
                        height: 25.h,
                        width: 25.h,
                        child: Icon(
                          Icons.add_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(18),
                  StatefulBuilder(
                    builder: (context, setState) => InkWell(
                      onTap: () async {
                        model = await showModalBottomSheet(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35.r),
                              topRight: Radius.circular(35.r),
                            ),
                          ),
                          context: context,
                          builder: (context) => const TitlesSheet(),
                        );
                        if (model?.location.isNotEmpty ?? false) {
                          final list = model!.location.split(' ');
                          list.removeAt(0);
                          String location = list.join(' ');

                          CacheHelper.setCurrentLocation(location);
                          GetLocation.controller.add(true);
                        }
                        bloc.addressId = model?.id.toString();
                        if (model != null) {
                          setState(
                                () {},
                          );
                        }
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(
                              color:  AppColor.mainColor,
                            ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 230.w,
                                child: Text(
                                  CacheHelper.getCurrentLocation() ??
                                      (context.locale.languageCode == "en"
                                          ? "Select address"
                                          : "اختر عنوان"),
                                  style: TextStyleTheme.textStyle14Bold.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.keyboard_arrow_up_rounded,
                                color: AppColor.mainColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(32),
                  Text(
                    LocaleKeys.complete_order_delivery_time.tr(),
                    style: TextStyleTheme.textStyle14Bold,
                  ),
                  verticalSpace(13),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            datePicker = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030),
                            );
                            setState(() {});
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(
                                color: AppColor.mainColor.withOpacity(0.1),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  horizontalSpace(12),
                                  Text(
                                    datePicker == null
                                        ? LocaleKeys
                                        .complete_order_choose_date_and_day
                                        .tr()
                                        : datePicker.toString().split(" ")[0],
                                    style: TextStyleTheme.textStyle14Bold.copyWith(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Spacer(),
                                  AppImage(AppImages.date),
                                  horizontalSpace(8),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      horizontalSpace(15),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            timePicker = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            setState(() {});
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(
                                color: AppColor.mainColor.withOpacity(0.1),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  horizontalSpace(12),
                                  Text(
                                    timePicker == null
                                        ? LocaleKeys.complete_order_choose_time
                                        .tr()
                                        : " ${timePicker?.minute.toString()} : ${timePicker?.hour.toString()}",
                                    style: TextStyleTheme.textStyle14Bold.copyWith(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Spacer(),
                                  AppImage(AppImages.time),
                                  horizontalSpace(12),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                 verticalSpace(21),
                  Text(
                    LocaleKeys.complete_order_notes_and_instructions.tr(),
                    style: TextStyleTheme.textStyle14Bold,
                  ),
                  TextField(
                    controller: bloc.note,
                    maxLines: 3,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.r),
                        borderSide: BorderSide(
                          color: AppColor.mainColor.withOpacity(.1),
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(24.5),
                  Text(
                    LocaleKeys.complete_order_choose_payment_way.tr(),
                    style: TextStyleTheme.textStyle14Bold,
                  ),
                  verticalSpace(18),
                  StatefulBuilder(
                    builder: (context, setState) => Row(
                      children: [
                        _CustomPayWay(
                          onTap: () {
                            isKash = true;
                            isCards = false;
                            isWallet = false;
                            setState(
                                  () {},
                            );
                          },
                          isTrue: isKash,
                          imagePath: AppImages.money,
                          title: LocaleKeys.complete_order_cash.tr(),
                        ),
                        horizontalSpace(15),
                        _CustomPayWay(
                          onTap: () {
                            isKash = false;
                            isCards = true;
                            isWallet = false;
                            setState(
                                  () {},
                            );
                          },
                          isCard: true,
                          fontSize: isCards ? 11 : 10,
                          isTrue: isCards,
                          imagePath: 'assets/images/card_payments.png',
                          title: context.locale.languageCode == "en"
                              ? "Credit Cart"
                              : 'بطاقات الدفع',
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        _CustomPayWay(
                          onTap: () {
                            isKash = false;
                            isCards = false;
                            isWallet = true;
                            setState(
                                  () {},
                            );
                          },
                          isTrue: isWallet,
                          imagePath: 'assets/icons/account/Wallet.svg',
                          title: LocaleKeys.my_account_wallet.tr(),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(15),
                  Text(
                    LocaleKeys.orders_order_summary.tr(),
                    style: TextStyleTheme.textStyle14Bold,
                  ),
                  verticalSpace(4),
                  KiwiContainer().resolve<CartBloc>().cartData!.isVip == 1
                      ? Text(
                    KiwiContainer()
                        .resolve<CartBloc>()
                        .cartData!
                        .vipMessage,
                    style:
                    TextStyle(fontSize: 13.sp, color: Colors.orange),
                    textAlign: TextAlign.center,
                  )
                      : verticalSpace(4),
                  SizedBox(
                    height: 4.h,
                  ),
                  CustomOrdersMoney(
                    model: KiwiContainer().resolve<CartBloc>().cartData!,
                    isCompleteOrder: true,
                  ),
                  verticalSpace(24),
                  BlocBuilder(
                    bloc: bloc,
                    builder: (context, state) {
                      if (state is AddOrderLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return AppButton(
                        text: LocaleKeys.complete_order_finish_order.tr(),
                        textStyle: TextStyleTheme.textStyle15Bold.copyWith(
                          color: AppColor.white,
                        ),
                        onPressed: () {
                          bloc.add(
                            AddOrderEvent(
                              date: datePicker.toString().split(" ")[0],
                              time:
                              "${timePicker?.hour.toString()}:${timePicker?.minute.toString()}"
                                  .trim(),
                              payType: isWallet
                                  ? 'wallet'
                                  : isCards
                                  ? 'card'
                                  : 'cash',
                            ),
                          );
                        },
                      );
                    },
                  ),
                  verticalSpace(16),
                ],
              ),
            ),
          ),
          // extendBody: true,
        ),
      ),
    );
  }
}

class _CustomPayWay extends StatefulWidget {
  const _CustomPayWay({
    this.isTrue = true,
    required this.imagePath,
    required this.title,
    this.fontSize = 16,
    required this.onTap,
    this.isCard = false,
  });
  final bool isTrue;
  final bool isCard;
  final String imagePath;
  final String title;
  final int fontSize;
  final void Function() onTap;
  @override
  State<_CustomPayWay> createState() => __CustomPayWayState();
}

class __CustomPayWayState extends State<_CustomPayWay> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: widget.onTap,
        child: SizedBox(
          height: 48.h,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.r),
              border:
              Border.all(
                  width: widget.isTrue ? 3 : 1,
                  color: AppColor.mainColor,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 4.w),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppImage(
                      widget.imagePath,
                      height: widget.isTrue ? 16.h : 14.h,
                    ),
                    Flexible(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            color: AppColor.mainColor,
                            fontSize: widget.isTrue
                                ? widget.fontSize.sp
                                : widget.isCard
                                ? 9.sp
                                : 12.sp,
                            fontWeight: FontWeight.bold,
                        ),
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
