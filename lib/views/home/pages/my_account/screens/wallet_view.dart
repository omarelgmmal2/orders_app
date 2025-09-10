import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/logic/helper_methods.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import 'package:vegetable_orders_project/generated/locale_keys.g.dart';
import 'package:vegetable_orders_project/views/home/pages/my_account/screens/currency_history_view.dart';
import '../../../../../core/design/custom_app_bar.dart';
import '../../../../../core/design/custom_outline_button.dart';
import '../../../../../features/my_account/wallet/wallet_bloc.dart';
import '../widget/currency_history_item.dart';
import '../widget/custom_charge_alert.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  final bloc = KiwiContainer().resolve<WalletBloc>();

  @override
  void initState() {
    bloc.add(GetWalletEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.my_account_wallet.tr()),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is GetWalletLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              verticalSpace(24),
              DecoratedBox(
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(17.r),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 17,
                          color: Colors.black.withOpacity(0.03),
                      )
                    ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 42.h),
                  child: SizedBox(
                    width: double.infinity.w,
                    child: Column(
                      children: [
                        Text(
                          LocaleKeys.wallet_your_balance.tr(),
                          style: TextStyleTheme.textStyle20Bold,
                        ),
                        Text(
                          '${bloc.wallet} ${LocaleKeys.r_s.tr()}',
                          style: TextStyleTheme.textStyle24Bold,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              verticalSpace(28),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomOutlineButton(
                  title: LocaleKeys.wallet_charge_now.tr(),
                  onPress: () {
                    showDialog(
                      context: context,
                      builder: (context) =>  CustomChargeAlert(bloc: bloc,),
                    );
                  },
                ),
              ),
              verticalSpace(55),
              Row(
                children: [
                  horizontalSpace(16),
                  Text(
                    LocaleKeys.wallet_history_transactions.tr(),
                    style: TextStyleTheme.textStyle16Bold,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => navigateTo(
                        toPage: CurrencyHistoryView(
                          bloc: bloc,
                        ),
                    ),
                    child: Text(
                      LocaleKeys.wallet_see_more.tr(),
                      style: TextStyleTheme.textStyle16Light.copyWith(
                        color: AppColor.mainColor,
                      ),
                    ),
                  ),
                  horizontalSpace(16),
                ],
              ),
             verticalSpace(8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                itemBuilder: (context, index) => CurrencyHistoryItem(
                  modelPaginated: bloc.listPaginated[index],
                  isCharge: false,
                  isWallet: true,
                ),
                itemCount: bloc.listPaginated.length,
              )
            ],
          );
        },
      ),
    );
  }
}