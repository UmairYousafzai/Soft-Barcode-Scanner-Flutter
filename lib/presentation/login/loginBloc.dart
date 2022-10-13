import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_barcode_scanner/presentation/login/login_event.dart';
import 'package:soft_barcode_scanner/presentation/login/login_state.dart';
import 'package:soft_barcode_scanner/data/dataproviders/repositories/data_repository.dart';
import 'package:soft_barcode_scanner/utils/form_submission_status.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  DataRepository dataRepository;

  LoginBloc({required this.dataRepository}) : super(LoginState()) {
    on<LoginUserNameChangedEvent>(
        (event, emit) => emit(state.copyWith(username: event.userName)));
    on<LoginPasswordChangedEvent>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<LoginCredentialsSubmittedEvent>((event, emit) {
      login(event, emit);
    });
  }

  void login(
    LoginCredentialsSubmittedEvent event,
    Emitter<LoginState> emitter,
  ) async {
    if (state.isValidPassword && state.isValidUserName) {
      emit(state.copyWith(formStatus: FormSubmittingStatus()));
      try {
        var result = await dataRepository.login(
            username: state.username, password: state.password);
        if (result.code == 200) {
          emit(state.copyWith(formStatus: SubmissionSuccess()));
        } else {
          emit(state.copyWith(
              formStatus:
                  SubmissionFailed("${result.message}, Code:${result.code}")));
        }
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
      }
    }
  }
// void login(
//   LoginCredentialsSubmittedEvent event,
//   Emitter<LoginState> emitter,
// ) async {
//   if (state.isValidPassword && state.isValidUserName) {
//     emit(state.copyWith(formStatus: FormSubmittingStatus()));
//     var result = await dataRepository.login(
//         username: state.username, password: state.password);
//     if (result.isSuccess) {
//       emit(state.copyWith(formStatus: SubmissionSuccess()));
//     } else {
//       emit(state.copyWith(
//           formStatus: SubmissionFailed(
//               result.error?.toString() ?? "Unknown exception")));
//     }
//   }
// }
}
