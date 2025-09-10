part of 'products_bloc.dart';

@immutable
class ProductsStates {}

final class GetFavoriteProductLoadingState extends ProductsStates {}

final class GetFavoriteProductSuccessState extends ProductsStates {}


final class GetFavoriteProductFailureState extends ProductsStates {
  final String msg;

  GetFavoriteProductFailureState({required this.msg});
}

///////////////////////////////////

class StartAddSuccessState extends ProductsStates {}

class StartRemoveSuccessState extends ProductsStates {}

///////////////////////////////////

class AddFavoriteSuccessState extends ProductsStates {}

class AddFavoriteFailedState extends ProductsStates {}

///////////////////////////////////

class RemoveFavoriteSuccessState extends ProductsStates {}

class RemoveFavoriteFailedState extends ProductsStates {}

////////////////////////////////////////////

class ProductsSuccessState extends ProductsStates {
  final List<ProductsModel> list;

  ProductsSuccessState({required this.list});
}
class ProductsLoadingState extends ProductsStates {}

class ProductsFailureState extends ProductsStates {
  final String msg;

  ProductsFailureState({required this.msg});
}
