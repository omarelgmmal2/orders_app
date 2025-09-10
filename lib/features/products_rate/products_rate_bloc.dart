import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vegetable_orders_project/core/logic/dio_helper.dart';
import '../../model/products_rate_model.dart';
part 'products_rate_event.dart';
part 'products_rate_state.dart';

class ProductRateBloc extends Bloc<ProductsRateEvents, ProductsRateStates> {
  ProductRateBloc() : super(ProductsRateStates()) {
    on<ProductsRateEvent>(_productRateGetData);
  }

  Future<void> _productRateGetData(
      ProductsRateEvent event, Emitter<ProductsRateStates> emit) async {
    emit(ProductsRateLoadingState());
    final response =
    await DioHelper().getData(endPoint: "products/${event.id}/rates");
    if (response.isSuccess) {
      final model = ProductRateData.fromJson(response.response!.data);
      emit(ProductsRateSuccessState(list: model.model));
    } else {
      emit(ProductsRateFailureState(msg: response.message));
    }
  }
}
