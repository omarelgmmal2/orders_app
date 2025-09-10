part of 'products_rate_bloc.dart';

@immutable
class ProductsRateStates {}

class ProductsRateSuccessState extends ProductsRateStates {
  final List<ProductsRateModel> list;

  ProductsRateSuccessState({required this.list});
}

class ProductsRateLoadingState extends ProductsRateStates {}

class ProductsRateFailureState extends ProductsRateStates {
  final String msg;

  ProductsRateFailureState({required this.msg});
}
