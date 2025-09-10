import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../core/logic/dio_helper.dart';
import '../../model/products_model.dart';
part 'similar_products_event.dart';
part 'similar_products_state.dart';

class GetSimilarProductBloc
    extends Bloc<GetSimilarProductsEvents, GetSimilarProductStates> {
  GetSimilarProductBloc() : super(GetSimilarProductStates()) {
    on<GetSimilarProductsEvent>(_getSimilarProductData);
  }

  Future<void> _getSimilarProductData(GetSimilarProductsEvent event, Emitter<GetSimilarProductStates> emit) async {
    emit(GetSimilarProductLoadingState());
    final response = await DioHelper().getData(endPoint: 'categories/${event.id}');
    if (response.isSuccess) {
      final model = ProductsData.fromJson(response.response!.data);
      emit(GetSimilarProductSuccessState(model: model.model));
    } else {
      emit(GetSimilarProductFailedState(msg: response.message));
    }
  }
}
