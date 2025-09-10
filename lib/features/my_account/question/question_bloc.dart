import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../model/question_model.dart';
part 'question_event.dart';
part 'question_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvents, QuestionsStates> {
  QuestionsBloc() : super(QuestionsStates()) {
    on<GetQuestionsEvent>(_getQuestions);
  }
  List<QuestionModel> list = [];

  Future<void> _getQuestions(
      GetQuestionsEvent event, Emitter<QuestionsStates> emit) async {
    emit(GetQuestionsLoading());
    final response = await DioHelper().getData(endPoint: '/faqs');
    if (response.isSuccess) {
      list = QuestionsData.fromJson(response.response!.data).data;
      emit(GetQuestionsSuccess());
    } else {
      emit(GetQuestionsFailed());
    }
  }
}
