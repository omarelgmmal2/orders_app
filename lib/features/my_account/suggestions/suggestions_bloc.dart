import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';
part 'suggestions_event.dart';
part 'suggestions_state.dart';

class SuggestionsBloc extends Bloc<SuggestionsEvents, SuggestionsStates> {
  SuggestionsBloc() : super(SuggestionsStates()) {
    on<SendSuggestionsEvent>(_sendData);
  }
  final name = TextEditingController();
  final phone = TextEditingController();
  final content = TextEditingController();

  Future<void> _sendData(
      SendSuggestionsEvent event, Emitter<SuggestionsStates> emit) async {
    emit(SentSuggestionsLoading());
    final response = await DioHelper().sendData(
        endPoint: '/contact',
        data: {
      "fullname": name.text,
      "phone": phone.text,
      "content": content.text,
    });
    if (response.isSuccess) {
      showMessage(message: response.message, type: MessageType.success);
      Navigator.pop(navigatorKey.currentContext!);
      emit(SentSuggestionsSuccess());
    } else {
      showMessage(message: response.message);

      emit(SentSuggestionsFailed());
    }
  }
}
