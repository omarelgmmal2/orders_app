import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:vegetable_orders_project/auth/confirm_code/confirm_code_screen.dart';
import 'package:vegetable_orders_project/core/logic/dio_helper.dart';
import 'package:vegetable_orders_project/core/logic/helper_methods.dart';
import 'package:vegetable_orders_project/core/utils/app_strings.dart';
import '../../model/cities_model.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterStates> {
  RegisterBloc() : super(RegisterStates()) {
    on<RegisterEvent>(_register);
  }

  CityModel? city;
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final cityController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  final cityFocusNode = FocusNode();
  final nameFocusNode = FocusNode();

  void _register(RegisterEvent event, Emitter<RegisterStates> emit) async {
    if (formKey.currentState!.validate()) {
      emit(RegisterLoadingState());
      final response = await DioHelper().sendData(
        endPoint: AppStrings.registerEndPoint,
        data: {
          "fullname": nameController.text,
          "phone": phoneController.text,
          "password": passwordController.text,
          "password_confirmation": confirmPasswordController.text,
          "country_id": '1',
          "city_1": city!.id,
        },
      );
      if (response.isSuccess) {
        showMessage(message: response.message, type: MessageType.success);
        emit(RegisterSuccessState());
        navigateTo(
          toPage: ConfirmCodeScreen(
            isActive: true,
            phone: phoneController.text,
          ),
        );
      } else {
        showMessage(message: response.message);
        emit(RegisterFailureState());
      }
    }else{
      autoValidateMode = AutovalidateMode.always;
    }
  }
}
