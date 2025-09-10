import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import '../../../../../core/design/custom_app_bar_icon.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../features/products/products_bloc.dart';
import '../../../../../model/products_model.dart';
import '../../../../../model/search_model.dart';

class CustomFavouriteIconAddOrRemove extends StatefulWidget {
  final ProductsModel? model;
  final SearchResult? searchModel;

  const CustomFavouriteIconAddOrRemove({
    super.key,
    this.model,
    this.searchModel,
  });

  @override
  State<CustomFavouriteIconAddOrRemove> createState() =>
      _CustomFavouriteIconAddOrRemoveState();
}

class _CustomFavouriteIconAddOrRemoveState
    extends State<CustomFavouriteIconAddOrRemove> {
  final bloc = KiwiContainer().resolve<ProductsBloc>();

  @override
  Widget build(BuildContext context) {
    bool isFavourite =
        widget.model?.isFavorite ?? widget.searchModel!.isFavorite;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Row(
        children: [
          const CustomAppBarIcon(),
          const Spacer(),
          BlocConsumer(
            bloc: bloc,
            listener: (context, state) {
              if (state is StartAddSuccessState) {
                isFavourite = true;
              } else if (state is StartRemoveSuccessState) {
                isFavourite = false;
              }
            },
            builder: (context, state) {
              return CustomAppBarIcon(
                onTap: () {
                  if (widget.model != null) {
                    if (isFavourite) {
                      bloc.add(
                        RemoveProductsFromFavsEvent(id: widget.model!.id),
                      );
                    } else {
                      bloc.add(AddProductsToFavsEvent(id: widget.model!.id));
                    }
                  } else {
                    if (isFavourite) {
                      bloc.add(
                        RemoveProductsFromFavsEvent(id: widget.searchModel!.id),
                      );
                    } else {
                      bloc.add(
                        AddProductsToFavsEvent(id: widget.searchModel!.id),
                      );
                    }
                  }
                },
                isBack: false,
                child: !isFavourite
                    ? Icon(
                        Icons.favorite_border,
                        color: AppColor.mainColor,
                        size: 20,
                      )
                    : Icon(Icons.favorite, color: AppColor.red, size: 20),
              );
            },
          ),
        ],
      ),
    );
  }
}
