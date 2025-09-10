part of 'get_category_bloc.dart';

@immutable
class GetCategoryStates {}

class GetCategorySuccessState extends GetCategoryStates {
  final List<GetCategoriesModel> model;

  GetCategorySuccessState({required this.model});
}
class GetCategoryLoadingState extends GetCategoryStates {}
class GetCategoryFailureState extends GetCategoryStates {
  final String msg;

  GetCategoryFailureState({required this.msg});
}
