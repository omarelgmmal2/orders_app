import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import '../../../../../core/design/custom_app_bar.dart';
import '../../../../../features/my_account/wallet/wallet_bloc.dart';
import '../widget/currency_history_item.dart';

class CurrencyHistoryView extends StatefulWidget {
  const CurrencyHistoryView({super.key, required this.bloc});
  final WalletBloc bloc;

  @override
  State<CurrencyHistoryView> createState() => _CurrencyHistoryViewState();
}

class _CurrencyHistoryViewState extends State<CurrencyHistoryView> {
  @override
  void initState() {
    widget.bloc.add(GetWalletEventPaginated());
    super.initState();
  }

  @override
  void dispose() {
    widget.bloc.pageNumber = 1;
    widget.bloc.listPaginated = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'سجل المعاملات'),
      body: BlocBuilder(
        bloc: widget.bloc,
        builder: (context, state) {
          if (state is GetWalletPaginatedLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.mainColor,
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels ==
                    notification.metrics.maxScrollExtent &&
                    notification is ScrollUpdateNotification) {
                  widget.bloc
                      .add(GetWalletEventPaginated(isLoadingPagination: true));
                }
                return true;
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                itemBuilder: (context, index) => CurrencyHistoryItem(
                  isWallet: false,
                  isCharge: false,
                  modelPaginated: widget.bloc.listPaginated[index],
                ),
                itemCount: widget.bloc.listPaginated.length,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder(
        bloc: widget.bloc,
        builder: (context, state) {
          if (state is GetWalletFromPaginationLoadingState) {
            return SafeArea(
              child: SizedBox(
                height: 45.h,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColor.mainColor,
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}