part of 'register_user_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class RegisterUserState extends Equatable {
  const RegisterUserState(
      {this.name = const Name.pure(),
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.confirmedPassword = const ConfirmedPassword.pure(),
      this.status = FormzStatus.pure,
      this.errorMessage,
      this.emailVerified = false});

  final Name name;
  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final String? errorMessage;
  final bool emailVerified;

  @override
  List<Object> get props => [name, email, password, confirmedPassword, status];

  RegisterUserState copyWith(
      {Name? name,
      Email? email,
      Password? password,
      ConfirmedPassword? confirmedPassword,
      FormzStatus? status,
      String? errorMessage,
      bool? emailVerified}) {
    return RegisterUserState(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        confirmedPassword: confirmedPassword ?? this.confirmedPassword,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        emailVerified: emailVerified ?? this.emailVerified);
  }
}
