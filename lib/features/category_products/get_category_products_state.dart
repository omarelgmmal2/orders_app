part of 'get_category_products_bloc.dart';

@immutable
class GetCategoryProductsStates {}

class GetCategoryProductsSuccessState extends GetCategoryProductsStates {
  final List<ProductsModel> list;

  GetCategoryProductsSuccessState({required this.list});
}
class GetCategoryProductsLoadingState extends GetCategoryProductsStates {}
class GetCategoryProductsFailureState extends GetCategoryProductsStates {
  final String msg;

  GetCategoryProductsFailureState({required this.msg});
}
