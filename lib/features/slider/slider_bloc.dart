import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vegetable_orders_project/core/logic/dio_helper.dart';
import 'package:vegetable_orders_project/core/utils/app_strings.dart';
import '../../model/slider_model.dart';
part 'slider_event.dart';
part 'slider_state.dart';

class SliderBloc extends Bloc<SliderEvents, SliderStates> {
  SliderBloc() : super(SliderStates()) {
    on<SliderEvent>(_getData);
  }

  bool isTransitionSlider = false;

  Future<void> _getData(SliderEvent event,Emitter<SliderStates>emit)async{
    emit(SliderLoadingState());
    final response = await DioHelper().getData(endPoint: AppStrings.slidersEndPoint);
    if(response.isSuccess){
      final model = SliderData.fromJson(response.response!.data);
      emit(SliderSuccessState(model: model.model));
    }else{
      emit(SliderFailureState(msg: response.message));
    }
  }
}
