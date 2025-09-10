part of 'get_category_products_bloc.dart';

@immutable
class GetCategoryProductsEvents {}

class GetCategoryProductsEvent extends GetCategoryProductsEvents {
  final int id;

  GetCategoryProductsEvent({required this.id});
}
