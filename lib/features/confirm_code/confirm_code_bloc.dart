import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vegetable_orders_project/auth/login/login_screen.dart';
import 'package:vegetable_orders_project/core/logic/dio_helper.dart';
import 'package:vegetable_orders_project/core/utils/app_strings.dart';
import '../../auth/change_password/change_password_screen.dart';
import '../../core/logic/helper_methods.dart';
part 'confirm_code_event.dart';
part 'confirm_code_state.dart';

class ConfirmCodeBloc extends Bloc<ConfirmCodeEvents, ConfirmCodeStates> {
  ConfirmCodeBloc() : super(ConfirmCodeStates()) {
    on<ConfirmCodeEvent>(_verify);
    on<ResendCodeEvent>(_resend);
  }

  final formKey = GlobalKey<FormState>();
  final confirmCodeController = TextEditingController();
  final phoneController = TextEditingController();
  bool isTimerFinished = false;

  void _resend(ResendCodeEvent event, Emitter<ConfirmCodeStates> emit) async {
    await DioHelper().sendData(
      endPoint: AppStrings.resendCodeEndPoint,
      data: {"phone": event.phone},
    );
  }

  void _verify(ConfirmCodeEvent event, Emitter<ConfirmCodeStates> emit) async {
    emit(ConfirmCodeLoadingState());
    if (event.isActive) {
      await DioHelper().sendData(
        endPoint: AppStrings.resendCodeEndPoint,
        data: {"phone": event.phone},
      );
    }

    final response = await DioHelper().sendData(
      endPoint: AppStrings.verifyEndPoint,
      data: {
        "code": confirmCodeController.text,
        "phone": event.phone,
        "device_token": "test",
        "type": Platform.operatingSystem,
      },
    );
    if (response.isSuccess) {
      showMessage(
        message: navigatorKey.currentContext!.locale.languageCode == 'ar'
            ? "تم التفعيل بنجاح"
            : "Activation completed successfully",
        type: MessageType.success,
      );
      if (event.isActive) {
        navigateTo(toPage: const LoginScreen(), isRemove: true);
      } else {
        navigateTo(
          toPage: ChangePasswordScreen(phone: event.phone),
          isRemove: true,
        );
      }
      emit(ConfirmCodeSuccessState());
    } else {
      showMessage(message: response.message);
      emit(ConfirmCodeFailureState());
    }
  }
}
