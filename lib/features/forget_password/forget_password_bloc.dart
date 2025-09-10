import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vegetable_orders_project/auth/confirm_code/confirm_code_screen.dart';
import 'package:vegetable_orders_project/core/logic/dio_helper.dart';
import 'package:vegetable_orders_project/core/logic/helper_methods.dart';
import 'package:vegetable_orders_project/core/utils/app_strings.dart';
part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc extends Bloc<ForgetPasswordEvents, ForgetPasswordStates> {
  ForgetPasswordBloc() : super(ForgetPasswordStates()) {
    on<ForgetPasswordEvent>(_sendData);
  }

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final phoneController = TextEditingController();
  final phoneFocusNode = FocusNode();


  Future<void> _sendData(ForgetPasswordEvent event,Emitter<ForgetPasswordStates>emit)async{
    if(formKey.currentState!.validate()){
      emit(ForgetPasswordLoadingState());
      final response = await DioHelper().sendData(
          endPoint: AppStrings.forgetPasswordEndPoint,
        data: {
            "phone" : event.phone,
        },
      );
      if(response.isSuccess){
        emit(ForgetPasswordSuccessState());
        showMessage(message: response.message,type: MessageType.success);
        if(!event.resend){
          navigateTo(
            toPage: ConfirmCodeScreen(
              isActive: false,
              phone: event.phone,
            ),
          );
        }
      }else {
        emit(ForgetPasswordFailureState());
        showMessage(message: response.message);
      }
    }else{
      autoValidateMode = AutovalidateMode.onUserInteraction;
    }
  }
}
