import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vegetable_orders_project/auth/login/login_screen.dart';
import '../../core/logic/cache_helper.dart';
import '../../core/logic/dio_helper.dart';
import '../../core/logic/helper_methods.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvents, LogoutStates> {
  LogoutBloc() : super(LogoutStates()) {
    on<LogoutEvent>((event, emit) async {
      emit(LogoutLoadingState());
      final response = await DioHelper().sendData(
        endPoint: 'logout',
      );

      if (response.isSuccess) {
        emit(LogoutSuccessState());
        CacheHelper.clearUserData();

        navigateTo(toPage: const LoginScreen(), isRemove: true);

        showMessage(message: response.message, type: MessageType.success);
      } else {
        emit(LogoutFailedState());
        showMessage(message: response.message);
      }
    });
  }
}
