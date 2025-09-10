part of 'search_products_bloc.dart';

@immutable
class SearchProductsStates {}

final class SearchProductsSuccessState extends SearchProductsStates {}
final class SearchProductsLoadingState extends SearchProductsStates {}
final class SearchProductsFailureState extends SearchProductsStates {}
