import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vegetable_orders_project/core/utils/app_strings.dart';
import '../../core/logic/dio_helper.dart';
import '../../model/cities_model.dart';
part 'get_cities_event.dart';
part 'get_cities_state.dart';

class GetCitiesBloc extends Bloc<GetCitiesEvents, GetCitiesStates> {
  GetCitiesBloc() : super(GetCitiesStates()) {
    on<GetCitiesEvent>(_getCityData);
  }

  Future<void> _getCityData(GetCitiesEvent event, Emitter<GetCitiesStates> emit) async {
    emit(GetCitiesLoadingState());
    var response = await DioHelper().getData(
        endPoint: AppStrings.citiesEndPoint,
    );
    if (response.isSuccess) {
      final model = CitiesDataModel.fromJson(response.response!.data);
      emit(GetCitiesSuccessState(cityData: model.cityData));
    } else {
      emit(GetCitiesFailureState());
    }
  }
}
