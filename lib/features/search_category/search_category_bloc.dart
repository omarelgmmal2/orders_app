import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../core/logic/dio_helper.dart';
import '../../model/search_model.dart';
part 'search_category_event.dart';
part 'search_category_state.dart';

class GetSearchCategoryBloc
    extends Bloc<GetSearchCategoryEvents, GetSearchCategoryStates> {
  GetSearchCategoryBloc() : super(GetSearchCategoryStates()) {
    on<GetSearchCategoryEvent>(_getSearch);
  }

  TextEditingController textController = TextEditingController();

  static GetSearchCategoryBloc get(context) => BlocProvider.of(context);
  double minPrice = 1;
  double maxPrice = 1000;
  String filter = 'asc';

  List<SearchResult> search = [];

  Future<void> _getSearch(GetSearchCategoryEvent event, Emitter<GetSearchCategoryStates> emit) async {
    emit(GetSearchCategoryLoadingState());
    final response = await DioHelper().getData(
      endPoint: "search_category/${event.id}/",
      data: {
        if (textController.text.isNotEmpty) "keyword": event.value,
        "filter": filter,
        "min_price": minPrice,
        "max_price": maxPrice,
      },
    );
    if (response.isSuccess) {
      search = SearchProductData.fromJson(
        response.response!.data,
      ).data.searchResult.toList();

      emit(GetSearchCategorySuccessState());
    } else {
      emit(GetSearchCategoryFailedState());
    }
  }
}
