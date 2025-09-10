import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vegetable_orders_project/core/utils/app_strings.dart';
import '../../core/logic/dio_helper.dart';
import '../../model/search_model.dart';
part 'search_products_event.dart';
part 'search_products_state.dart';

class SearchProductsBloc extends Bloc<SearchProductsEvents, SearchProductsStates> {
  SearchProductsBloc() : super(SearchProductsStates()) {
    on<SearchProductsEvent>(_getSearch);
  }

  bool isTranslate = false;
  bool isNotFound = false;
  TextEditingController textController = TextEditingController();
  String searchText = '';
  List<SearchResult> search = [];

  Future<void> _getSearch(SearchProductsEvent event, Emitter<SearchProductsStates> emit) async {
    emit(SearchProductsLoadingState());
    searchText = event.text;
    final response = await DioHelper().getData(
        endPoint: AppStrings.searchProductsEndPoint,
        data: {
      'keyword': event.text,
    });
    if (response.isSuccess) {
      search = SearchProductData.fromJson(response.response!.data)
          .data
          .searchResult
          .toList();
      if (event.text.isEmpty) {
        search.clear();
      }

      emit(SearchProductsSuccessState());
    } else {
      emit(SearchProductsFailureState());
    }
  }
}
