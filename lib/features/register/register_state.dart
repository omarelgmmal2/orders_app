part of 'register_bloc.dart';

@immutable
class RegisterStates {}

class RegisterSuccessState extends RegisterStates {}
class RegisterLoadingState extends RegisterStates {}
class RegisterFailureState extends RegisterStates {}
