part of 'products_bloc.dart';

@immutable
class ProductsEvents {}

class ProductsEvent extends ProductsEvents{}

class GetFavsProductsEvent extends ProductsEvents {
  final bool isLoading;

  GetFavsProductsEvent({required this.isLoading});
}

class AddProductsToFavsEvent extends ProductsEvents {
  final int id;

  AddProductsToFavsEvent({required this.id});
}

class RemoveProductsFromFavsEvent extends ProductsEvents {
  final int id;

  RemoveProductsFromFavsEvent({required this.id});
}
