import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../core/logic/cache_helper.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../model/profile_model.dart';
part 'get_profile_event.dart';
part 'get_profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvents, ProfileStates> {
  ProfileBloc() : super(ProfileStates()) {
    on<GetProfileEvent>(_getData);
  }

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  bool isLoading = true;

  UserDataProfile data = UserDataProfile();
  Future<void> _getData(
      GetProfileEvent event, Emitter<ProfileStates> emit) async {
    if (isLoading) emit(GetProfileDataLoadingState());
    final response = await DioHelper().getData(endPoint: 'client/profile');

    if (response.isSuccess) {
      isLoading = false;
      final model = ProfileData.fromJson(response.response!.data).data;
      CacheHelper.saveEditData(model);
      data = model;
      emit(GetProfileDataSuccessState(data: model));
    } else {
      emit(GetProfileDataFailedState());
    }
  }
}
