import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../core/logic/cache_helper.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../model/cities_model.dart';
import '../../../model/profile_model.dart';
part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditDataEvents, EditDataStates> {
  EditProfileBloc() : super(EditDataStates()) {
    on<EditProfileEvent>(_editData);
  }
  String? imagePath;
  CityModel? city;

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  Future<void> _editData(
      EditProfileEvent event, Emitter<EditDataStates> emit) async {
    if (formKey.currentState!.validate()) {
      emit(EditProfileDataLoadingState());
      final response =
      await DioHelper().sendData(endPoint: '/client/profile', data: {
        'image': imagePath != null
            ? DioHelper.convertPathToMultiPart(imagePath: imagePath!)
            : null,
        'fullname': event.fullName,
        'phone': event.phone,
        'city_id': city == null ? CacheHelper.getCityId() : city!.id,
      });

      if (response.isSuccess) {
        final model = ProfileData.fromJson(response.response!.data).data;
        CacheHelper.saveEditData(model);
        Navigator.pop(navigatorKey.currentContext!);

        showMessage(message: response.message, type: MessageType.success);

        emit(EditProfileDataSuccessState());
      } else {
        emit(EditProfileDataFailedState());
      }
    } else {
      autoValidateMode = AutovalidateMode.onUserInteraction;
    }
  }
}
