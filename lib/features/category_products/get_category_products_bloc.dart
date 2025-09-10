import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vegetable_orders_project/model/products_model.dart';
import '../../core/logic/dio_helper.dart';
part 'get_category_products_event.dart';
part 'get_category_products_state.dart';

class GetCategoryProductsBloc extends Bloc<GetCategoryProductsEvents, GetCategoryProductsStates> {
  GetCategoryProductsBloc() : super(GetCategoryProductsStates()) {
    on<GetCategoryProductsEvent>(_getData);
  }

  Future<void> _getData(GetCategoryProductsEvent event,Emitter<GetCategoryProductsStates>emit)async{
    emit(GetCategoryProductsLoadingState());
    final response = await DioHelper().getData(endPoint: "categories/${event.id}");
    if(response.isSuccess){
      final model = ProductsData.fromJson(response.response!.data);
      emit(GetCategoryProductsSuccessState(list: model.model));
    }else{
      emit(GetCategoryProductsFailureState(msg: response.message));
    }
  }
}
