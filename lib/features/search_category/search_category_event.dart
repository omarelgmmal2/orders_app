part of 'search_category_bloc.dart';

@immutable
class GetSearchCategoryEvents {}

class GetSearchCategoryEvent extends GetSearchCategoryEvents {
  final int id;
  final String value;
  final String? filter;
  final double? minPrice, maxPrice;
  GetSearchCategoryEvent({
    this.value = '',
    required  this.id,
    this.filter,
    this.minPrice,
    this.maxPrice,
  });
}