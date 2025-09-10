part of 'slider_bloc.dart';

@immutable
class SliderStates {}

class SliderSuccessState extends SliderStates {
  final List<SliderModel> model;

  SliderSuccessState({required this.model});
}
class SliderLoadingState extends SliderStates {}
class SliderFailureState extends SliderStates {
  final String msg;

  SliderFailureState({required this.msg});
}
