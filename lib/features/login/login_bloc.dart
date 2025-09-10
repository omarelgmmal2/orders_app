import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vegetable_orders_project/core/logic/cache_helper.dart';
import 'package:vegetable_orders_project/core/logic/dio_helper.dart';
import 'package:vegetable_orders_project/core/logic/helper_methods.dart';
import 'package:vegetable_orders_project/core/utils/app_strings.dart';
import 'package:vegetable_orders_project/model/login_model.dart';
import '../../views/home/home_view.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginBloc() : super(LoginStates()) {
    on<LoginEvent>(_login);
  }

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();


  void _login(LoginEvent event,Emitter<LoginStates>emit)async{
    if(formKey.currentState!.validate()){
      emit(LoginLoadingState());
      final response = await DioHelper().sendData(
          endPoint: AppStrings.loginEndPoint,
        data: {
            "phone" : phoneController.text,
            "password" : passwordController.text,
            "type" : Platform.operatingSystem,
            "device_token" : "test",
            "user_type" : "client",
        },
      );
      if(response.isSuccess){
        final model = UserData.fromJson(response.response!.data);
        await CacheHelper.saveUserData(model.model);
        showMessage(
          message: navigatorKey.currentContext!.locale.languageCode == 'ar'
              ? "تم التسجيل بنجاح"
              : "Login is successfully",
          type: MessageType.success,
        );
        emit(LoginSuccessState());
        navigateTo(toPage: const HomeView(), isRemove: true);
      }else{
        showMessage(message: response.message);
        emit(LoginFailerState());
      }
    }else {
      autoValidateMode = AutovalidateMode.always;
    }
  }
}
