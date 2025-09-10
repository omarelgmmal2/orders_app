part of 'search_products_bloc.dart';

@immutable
class SearchProductsEvents {}
class SearchProductsEvent extends  SearchProductsEvents{
  final String text;

  SearchProductsEvent({required this.text});
}
