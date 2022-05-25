import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../exceptions/exceptions.dart';
import '../../form_models/form_models.dart';
import '../../repositories/repositories.dart';

part 'register_user_state.dart';

class RegisterUserCubit extends Cubit<RegisterUserState> {
  RegisterUserCubit(this._authenticationRepository)
      : super(const RegisterUserState());

  final AuthenticationRepository _authenticationRepository;

  void nameChanged(String value) {
    final name = Name.dirty(value: value);
    emit(state.copyWith(
        name: name,
        status: Formz.validate(
            [name, state.email, state.password, state.confirmedPassword])));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
        email: email,
        status: Formz.validate(
            [state.name, email, state.password, state.confirmedPassword])));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
        password: password.value, value: state.confirmedPassword.value);
    emit(state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        status: Formz.validate(
            [state.name, state.email, password, confirmedPassword])));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword =
        ConfirmedPassword.dirty(password: state.password.value, value: value);
    emit(state.copyWith(
        confirmedPassword: confirmedPassword,
        status: Formz.validate(
            [state.name, state.email, state.password, confirmedPassword])));
  }

  void emailSent() async {
    await _authenticationRepository.sendEmailVerification();
  }

  Future<bool> emailVerified() async {
    bool isEmailVerified = await _authenticationRepository.checkEmailVerified();
    return isEmailVerified;
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.signUp(
          name: state.name.value,
          email: state.email.value,
          password: state.password.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
          errorMessage: e.message, status: FormzStatus.submissionFailure));
    } catch (_) {
      state.copyWith(status: FormzStatus.submissionFailure);
    }
  }
}
