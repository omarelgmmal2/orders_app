part of 'get_profile_bloc.dart';

@immutable

class ProfileStates {}

class GetProfileDataSuccessState extends ProfileStates {
  final UserDataProfile data;

  GetProfileDataSuccessState({required this.data});
}

class GetProfileDataFailedState extends ProfileStates {}

class GetProfileDataLoadingState extends ProfileStates {}
