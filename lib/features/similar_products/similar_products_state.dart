part of 'similar_products_bloc.dart';

@immutable
class GetSimilarProductStates {}

final class GetSimilarProductSuccessState extends GetSimilarProductStates {
  final List<ProductsModel> model;

  GetSimilarProductSuccessState({required this.model});
}

final class GetSimilarProductLoadingState extends GetSimilarProductStates {}

final class GetSimilarProductFailedState extends GetSimilarProductStates {
  final String msg;

  GetSimilarProductFailedState({required this.msg});
}
