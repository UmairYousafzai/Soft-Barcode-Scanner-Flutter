abstract class LoginEvent {}

class LoginUserNameChangedEvent extends LoginEvent {
  final String userName;

  LoginUserNameChangedEvent({required this.userName});
}

class LoginPasswordChangedEvent extends LoginEvent {
  final String password;

  LoginPasswordChangedEvent({required this.password});
}

class LoginCredentialsSubmittedEvent extends LoginEvent {}
