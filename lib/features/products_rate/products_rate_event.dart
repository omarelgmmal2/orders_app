part of 'products_rate_bloc.dart';

@immutable
class ProductsRateEvents {}

class ProductsRateEvent extends ProductsRateEvents {
  final int id;

  ProductsRateEvent({required this.id});
}
