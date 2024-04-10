sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadStarted extends LoginState {}

class LoginFinished extends LoginState {
  final String userName;
  LoginFinished({required this.userName});
}

class LoginFailed extends LoginState {}
