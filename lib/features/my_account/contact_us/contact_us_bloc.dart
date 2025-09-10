import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';
part 'contact_us_event.dart';
part 'contact_us_state.dart';

class ContactUsBloc extends Bloc<ContactUsEvents, ContactUsStates> {
  ContactUsBloc() : super(ContactUsStates()) {
    on<ContactUsEvent>(_sendData);
  }

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final contentController = TextEditingController();

  Future<void> _sendData(
      ContactUsEvent event, Emitter<ContactUsStates> emit) async {
    emit(ContactUsLoadingState());
    final response = await DioHelper().sendData(
        endPoint: 'contact',
        data: {
      "fullname": nameController.text,
      "phone": phoneController.text,
      "content": contentController.text,
    });

    if (response.isSuccess) {
      emit(ContactUsSuccessState());
      showMessage(message: response.message, type: MessageType.success);
      Navigator.pop(navigatorKey.currentContext!);
    } else {
      emit(ContactUsFailedState());
      showMessage(message: response.message);
    }
  }
}
