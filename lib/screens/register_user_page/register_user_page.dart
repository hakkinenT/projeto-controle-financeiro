import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../cubit/register_user/register_user_cubit.dart';
import '../../themes/themes.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

class RegisterUserPage extends StatelessWidget {
  const RegisterUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const SingleChildScrollView(
          padding: EdgeInsets.all(20), child: RegisterUserForm()),
    );
  }
}

class RegisterUserForm extends StatelessWidget {
  const RegisterUserForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterUserCubit, RegisterUserState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.pushReplacementNamed(context, verifyEmailPath);
        } else if (state.status.isSubmissionFailure) {
          customAlertDialog(
              context: context,
              title: 'Erro',
              message: state.errorMessage ??
                  'Houve um erro ao tentar cadastrar o usuário. Tente novamente mais tarde',
              informationIcon: Icons.error,
              informationColor: AppColors.informationErrorColor);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 120,
            child: AspectRatio(
              aspectRatio: 3 / 2,
              child: AppImage.logo,
            ),
          ),
          Text(
            AppText.textRegisterPage,
            textAlign: TextAlign.center,
            style: AppTypograph.headline6,
          ),
          const SizedBox(
            height: 40,
          ),
          const _NameInput(),
          const SizedBox(
            height: 8,
          ),
          const _EmailInput(),
          const SizedBox(
            height: 8,
          ),
          const _PasswordInput(),
          const SizedBox(
            height: 8,
          ),
          const _ConfirmedPasswordInput(),
          const SizedBox(
            height: 8,
          ),
          const _RegisterUserButton(),
          const SizedBox(
            height: 8,
          ),
          CustomRichText(
            text: 'Já tem uma conta? ',
            clickableText: 'Login',
            onTap: () {
              Navigator.pushNamed(context, loginPath);
            },
          )
        ],
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterUserCubit, RegisterUserState>(
        buildWhen: (previous, current) => previous.name != current.name,
        builder: (context, state) {
          return CustomTextFormField(
            key: const Key('signUpForm_nameInput_textField'),
            autofocus: true,
            onChanged: (name) =>
                context.read<RegisterUserCubit>().nameChanged(name),
            labelText: 'Nome',
            helperText: '',
            errorText: state.name.invalid
                ? 'Informe um nome válido'
                : state.name.error != null
                    ? 'Informe um nome'
                    : null,
            textInputAction: TextInputAction.next,
          );
        });
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterUserCubit, RegisterUserState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return CustomTextFormField(
            key: const Key('signUpForm_emailInput_textfield'),
            onChanged: (email) =>
                context.read<RegisterUserCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            labelText: 'E-mail',
            helperText: '',
            errorText: state.email.invalid ? 'E-mail inválido' : null,
            textInputAction: TextInputAction.next,
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterUserCubit, RegisterUserState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return CustomTextFormField(
            key: const Key('signUpForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<RegisterUserCubit>().passwordChanged(password),
            obscureText: true,
            labelText: 'Senha',
            helperText: '',
            errorText: state.password.invalid ? 'Senha Inválida' : null,
            textInputAction: TextInputAction.next,
          );
        });
  }
}

class _ConfirmedPasswordInput extends StatelessWidget {
  const _ConfirmedPasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterUserCubit, RegisterUserState>(
        buildWhen: (previous, current) =>
            previous.password != current.password ||
            previous.confirmedPassword != current.confirmedPassword,
        builder: (context, state) {
          return CustomTextFormField(
            key: const Key('signUpForm_confirmedPasswordInput_textFiel'),
            onChanged: (confirmPassword) => context
                .read<RegisterUserCubit>()
                .confirmedPasswordChanged(confirmPassword),
            obscureText: true,
            labelText: 'Confirmar Senha',
            helperText: '',
            errorText: state.confirmedPassword.invalid
                ? 'As senhas não são iguais'
                : null,
          );
        });
  }
}

class _RegisterUserButton extends StatelessWidget {
  const _RegisterUserButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterUserCubit, RegisterUserState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : CustomElevatedButton(
                  buttonLabel: 'Cadastrar',
                  onPressed: state.status.isValidated
                      ? () => context
                          .read<RegisterUserCubit>()
                          .signUpFormSubmitted()
                      : null,
                  width: double.maxFinite,
                  height: 52);
        });
  }
}
