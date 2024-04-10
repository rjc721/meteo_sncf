import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meteo_sncf/service/sign_in_user_uc.dart';
import 'package:meteo_sncf/view/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void login({required String email, required String password}) async {
    emit(LoginLoadStarted());
    try {
      final userName = await GetIt.I<SignInUserUC>().handle(email, password);
      if (userName == null) {
        emit(LoginFailed());
      } else {
        emit(LoginFinished(userName: userName));
      }
    } catch (_) {
      emit(LoginFailed());
    }
  }
}
