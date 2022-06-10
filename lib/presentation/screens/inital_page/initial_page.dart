import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../business_logic/business_logic.dart';
import '../../../themes/themes.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 96.0, left: 20, right: 20, bottom: 20),
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              customAlertDialog(
                  context: context,
                  title: 'Erro',
                  message:
                      state.errorMessage ?? 'Falha ao tentar fazer o login',
                  informationIcon: Icons.error,
                  informationColor: AppColors.informationErrorColor);
            } else if (state.status.isSubmissionSuccess) {
              Navigator.pushNamed(context, kHomePath);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 130,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: AppImage.logo,
                ),
              ),
              Text(
                AppText.kTextInitialPage,
                style: AppTypograph.headline6,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 88,
              ),
              CustomElevatedButton(
                  buttonLabel: 'Cadastrar',
                  onPressed: () {
                    Navigator.pushNamed(context, kRegisterPath);
                  },
                  width: double.maxFinite,
                  height: 52),
              const SizedBox(
                height: 16,
              ),
              Text(
                'ou',
                style: AppTypograph.paragraph,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomOutlinedButton(
                  buttonLabel: 'Entrar com E-mail',
                  onPressed: () {
                    Navigator.pushNamed(context, kLoginPath);
                  },
                  width: double.maxFinite,
                  height: 52),
              const SizedBox(
                height: 16,
              ),
              GoogleButton(
                  width: double.maxFinite,
                  height: 52,
                  onTap: () => context.read<LoginCubit>().logInWithGoogle())
            ],
          ),
        ),
      ),
    );
  }
}
