import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../auth/change_password/change_password_screen.dart';
import '../../auth/login/login_screen.dart';
import '../../core/logic/dio_helper.dart';
import '../../core/logic/helper_methods.dart';
part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvents, ChangePasswordStates> {
  ChangePasswordBloc() : super(ChangePasswordStates()) {
    on<CheckCodeEvent>(_checkCode);
    on<ResetPasswordEvent>(_resetPassword);
  }

  final formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  final newPasswordFocusNode = FocusNode();
  final confirmNewPasswordFocusNode = FocusNode();
  String? password;
  final confirmCodeController = TextEditingController();

  Future<void> _checkCode(
      CheckCodeEvent event, Emitter<ChangePasswordStates> emit) async {
    FocusScope.of(navigatorKey.currentContext!).unfocus();

    emit(CheckCodeLoadingState());
    final response = await DioHelper().sendData(endPoint: 'check_code', data: {
      "phone": event.phone,
      "code": confirmCodeController.text,
    });
    if (response.isSuccess) {
      emit(CheckCodeSuccessState());
      navigateTo(
        toPage: ChangePasswordScreen(
          phone: event.phone,
        ),
      );
    } else {
      emit(CheckCodeFailedState());
      showMessage(message: response.message);
    }
  }

  Future<void> _resetPassword(
      ResetPasswordEvent event, Emitter<ChangePasswordStates> emit) async {
    FocusScope.of(navigatorKey.currentContext!).unfocus();

    emit(ResetPasswordLoadingState());
    final response =
    await DioHelper().sendData(endPoint: 'reset_password', data: {
      "phone": event.phone,
      "code": '1111',
      "password": newPasswordController.text,
    });
    if (response.isSuccess) {
      emit(ResetPasswordSuccessState());
      showMessage(message: response.message, type: MessageType.success);
      navigateTo(toPage: const LoginScreen(), isRemove: true);
    } else {
      emit(ResetPasswordFailedState());
      showMessage(message: response.message);
    }
  }
}
