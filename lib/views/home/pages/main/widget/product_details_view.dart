import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/model/products_model.dart';
import 'package:vegetable_orders_project/views/home/pages/main/widget/product_details_bottom_nav_bar.dart';
import '../../../../../features/cart/cart_bloc.dart';
import '../../../../../model/search_model.dart';
import 'custom_favourite_icon_add_or_remove.dart';
import 'custom_product_details_list_view.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductsModel? model;
  final SearchResult? searchModel;
  final bool isMainView;

  const ProductDetailsView({
    super.key,
    this.model,
    this.searchModel,
    this.isMainView = true,
  });

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        KiwiContainer().resolve<CartBloc>().amountProduct = 1;
      },
      child: ColoredBox(
        color: AppColor.white,
        child: FadeIn(
          duration: const Duration(milliseconds: 500),
          child: Scaffold(
            bottomNavigationBar: ProductDetailsBottomNavBar(
              model: widget.model,
              searchModel: widget.searchModel,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  CustomFavouriteIconAddOrRemove(
                    model: widget.model,
                    searchModel: widget.searchModel,
                  ),
                  Expanded(
                    child: CustomProductDetailsListView(
                      model: widget.model,
                      searchModel: widget.searchModel,
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
