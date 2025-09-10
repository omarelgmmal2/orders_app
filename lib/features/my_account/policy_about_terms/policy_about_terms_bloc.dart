import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../model/policy_model.dart';
part 'policy_about_terms_event.dart';
part 'policy_about_terms_state.dart';

class PolicyBloc extends Bloc<PolicyEvents, PolicyStates> {
  PolicyBloc() : super(PolicyStates()) {
    on<GetPolicyEvent>(_getPolicy);
    on<GetAboutEvent>(_about);
    on<GetTermsEvent>(_terms);
  }

  Future<void> _getPolicy(
      GetPolicyEvent event, Emitter<PolicyStates> emit) async {
    emit(GetPolicyLoading());
    final response = await DioHelper().getData(endPoint: '/policy');
    if (response.isSuccess) {
      final model = PolicyData.fromJson(response.response!.data).data;
      emit(GetPolicySuccess(model: model));
    } else {
      emit(GetPolicyFailed());
    }
  }

  Future<void> _about(GetAboutEvent event, Emitter<PolicyStates> emit) async {
    emit(AboutLoadingState());
    final response = await DioHelper().getData(endPoint: '/about');
    if (response.isSuccess) {
      final model = AboutData.fromJson(response.response!.data).data;
      emit(AboutSuccessState(model: model));
    } else {
      emit(AboutFailedState());
    }
  }

  Future<void> _terms(GetTermsEvent event, Emitter<PolicyStates> emit) async {
    emit(TermsLoadingState());
    final response = await DioHelper().getData(endPoint: '/terms');
    if (response.isSuccess) {
      final model = TermsData.fromJson(response.response!.data).data;
      emit(TermsSuccessState(model: model));
    } else {
      emit(TermsFailedState());
    }
  }
}
