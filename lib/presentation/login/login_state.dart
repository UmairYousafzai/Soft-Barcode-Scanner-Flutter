import 'package:soft_barcode_scanner/utils/form_submission_status.dart';

class LoginState {
  final String username;

  bool get isValidUserName => username.length > 3;
  final String password;

  bool get isValidPassword => password.length > 6;
  bool isShowPassword = false;

  final FormSubmissionStatus formStatus;

  LoginState({
    this.username = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
    this.isShowPassword = false,
  });

  LoginState copyWith({
    String? username,
    String? password,
    FormSubmissionStatus? formStatus,
    bool? isShowPassword,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
      isShowPassword: isShowPassword ?? this.isShowPassword,
    );
  }
}
