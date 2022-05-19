import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/themes/app_typograph.dart';
import 'package:projeto_controle_financeiro/utils/constants/app_text.dart';
import 'package:projeto_controle_financeiro/utils/constants/routes_names.dart';
import 'package:projeto_controle_financeiro/widgets/buttons/custom_elevated_button.dart';
import 'package:projeto_controle_financeiro/widgets/buttons/custom_outlined_button.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 96.0, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 130,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset('assets/logo.png'),
              ),
            ),
            Text(
              AppText.textInitialPage,
              style: AppTypograph.headline6,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 109,
            ),
            CustomElevatedButton(
                buttonLabel: 'Cadastrar',
                onPressed: () {
                  Navigator.pushNamed(context, registerPath);
                },
                width: double.maxFinite,
                height: 52),
            const SizedBox(
              height: 24,
            ),
            CustomOutlinedButton(
                buttonLabel: 'Log in',
                onPressed: () {
                  Navigator.pushNamed(context, loginPath);
                },
                width: double.maxFinite,
                height: 52)
          ],
        ),
      ),
    );
  }
}
