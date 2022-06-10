import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../widgets/widgets.dart';

import '../../../business_logic/business_logic.dart';

import '../../../themes/themes.dart';
import '../../../utils/utils.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
          padding: EdgeInsets.all(20), child: LoginForm()),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          customAlertDialog(
              context: context,
              title: 'Erro',
              message: state.errorMessage ?? 'Falha ao tentar fazer o login',
              informationIcon: Icons.error,
              informationColor: AppColors.informationErrorColor);
        } else if (state.status.isSubmissionSuccess) {
          Navigator.pushReplacementNamed(context, kHomePath);
        }
      },
      child: Column(
        children: [
          SizedBox(
            height: 120,
            child: AspectRatio(
              aspectRatio: 3 / 2,
              child: AppImage.logo,
            ),
          ),
          Text(
            AppText.textLoginPage,
            textAlign: TextAlign.center,
            style: AppTypograph.headline6,
          ),
          const SizedBox(
            height: 40,
          ),
          const _EmailInput(),
          const SizedBox(
            height: 8,
          ),
          const _PasswordInput(),
          const SizedBox(
            height: 8,
          ),
          const _LoginButton(),
          const SizedBox(
            height: 16,
          ),
          CustomRichText(
              text: 'Não tem uma conta? ',
              clickableText: 'Cadastre-se',
              onTap: () {
                Navigator.pushNamed(context, kRegisterPath);
              })
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return CustomTextFormField(
              key: const Key('loginForm_emailInput_textField'),
              onChanged: (email) =>
                  context.read<LoginCubit>().emailChanged(email),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              labelText: 'E-mail',
              helperText: '',
              errorText: state.email.invalid ? 'E-mail inválido' : null);
        });
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return CustomTextFormField(
            key: const Key('loginForm_passwordInput_textField'),
            obscureText: true,
            onChanged: (password) =>
                context.read<LoginCubit>().passwordChanged(password),
            labelText: 'Senha',
            helperText: '',
            errorText: state.password.invalid ? 'Senha invalida' : null,
          );
        });
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : CustomElevatedButton(
                  buttonLabel: 'Login',
                  onPressed: state.status.isValidated
                      ? () => context.read<LoginCubit>().logInWithCredential()
                      : null,
                  width: double.maxFinite,
                  height: 52);
        });
  }
}
