part of 'cart_bloc.dart';

@immutable
class CartEvents {}

class ShowCartEvent extends CartEvents {
  final bool isLoading;

  ShowCartEvent({required this.isLoading});
}

class StoreProductCartEvent extends CartEvents {
  final int id;
  final int amount;
  final bool isProduct;
  final ProductsModel? model;
  final SearchResult? searchModel;

  StoreProductCartEvent(
      {this.searchModel,
        this.amount = 1,
        this.model,
        this.isProduct = false,
        required this.id,
      });
}

class UpdateProductCartEvent extends CartEvents {
  final int amount;
  final int id;

  UpdateProductCartEvent({required this.amount, required this.id});
}

class CounterProductsEvent extends CartEvents {
  final bool isAdd;

  CounterProductsEvent({required this.isAdd});
}

class DeleteProductCartEvent extends CartEvents {
  final int id;

  DeleteProductCartEvent({required this.id});
}
