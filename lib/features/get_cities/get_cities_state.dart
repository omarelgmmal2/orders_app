part of 'get_cities_bloc.dart';

@immutable
class GetCitiesStates {}

class GetCitiesSuccessState extends GetCitiesStates {
  final List<CityModel> cityData;
  GetCitiesSuccessState({required this.cityData});
}
class GetCitiesLoadingState extends GetCitiesStates {}
class GetCitiesFailureState extends GetCitiesStates {}
