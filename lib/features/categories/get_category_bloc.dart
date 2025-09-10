import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vegetable_orders_project/core/logic/dio_helper.dart';
import 'package:vegetable_orders_project/core/utils/app_strings.dart';
import 'package:vegetable_orders_project/model/get_categories_model.dart';
part 'get_category_event.dart';
part 'get_category_state.dart';

class GetCategoryBloc extends Bloc<GetCategoryEvents, GetCategoryStates> {
  GetCategoryBloc() : super(GetCategoryStates()) {
    on<GetCategoryEvent>(_getData);
  }

  bool isTransitionCategory = false;

  Future<void> _getData(
    GetCategoryEvent event,
    Emitter<GetCategoryStates> emit,
  ) async {
    emit(GetCategoryLoadingState());
    final response = await DioHelper().getData(
      endPoint: AppStrings.categoriesEndPoint,
    );
    if (response.isSuccess) {
      final model = GetCategoriesData.fromJson(response.response!.data);
      emit(GetCategorySuccessState(model: model.model));
    } else {
      emit(GetCategoryFailureState(msg: response.message));
    }
  }
}
