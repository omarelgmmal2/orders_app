part of 'similar_products_bloc.dart';

@immutable
class GetSimilarProductsEvents {}

class GetSimilarProductsEvent extends GetSimilarProductsEvents {
  final int id;

  GetSimilarProductsEvent({required this.id});
}
