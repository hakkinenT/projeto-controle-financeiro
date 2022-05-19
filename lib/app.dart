import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/router/app_router.dart';

import 'package:projeto_controle_financeiro/themes/app_theme.dart';
import 'package:projeto_controle_financeiro/widgets/buttons/button_google.dart';
import 'package:projeto_controle_financeiro/widgets/buttons/custom_drop_down_button.dart';
import 'package:projeto_controle_financeiro/widgets/buttons/custom_elevated_button.dart';
import 'package:projeto_controle_financeiro/widgets/buttons/custom_outlined_button.dart';
import 'package:projeto_controle_financeiro/widgets/dialogs/custom_alert_dialog.dart';
import 'package:projeto_controle_financeiro/widgets/expanded_tile/custom_expanded_title.dart';
import 'package:projeto_controle_financeiro/widgets/expanded_tile/expanded_item.dart';
import 'package:projeto_controle_financeiro/widgets/fields/custom_text_field.dart';

import 'modules/login/authentication/auth_service.dart';
import 'themes/app_colors.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final AppRouter? router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      onGenerateRoute: router!.generateRoute,
    );
  }
}

class LoginTest extends StatelessWidget {
  const LoginTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                try {
                  UserModel? userModel = await AuthService()
                      .signInWithEmailAndPassword(
                          'developer.thol@gmail.com', '12345678');
                  if (userModel != null) {
                    // ignore: avoid_print
                    print(userModel.uid);
                    print(userModel.displayName);
                  }
                } catch (e) {
                  // ignore: avoid_print
                  print(e.toString());
                }
              },
              child: const Text('Login')),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () async {
                UserModel? userModel = await AuthService().signInWithGoogle();
                if (userModel != null) {
                  // ignore: avoid_print
                  print(userModel.uid);
                  print(userModel.displayName);
                }
              },
              child: const Text('Login com o Google')),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () async {
                await AuthService().signOut();
              },
              child: const Text('Logout')),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () async {
                await AuthService().signOutFromGoogle();
              },
              child: const Text('Logout from Google')),
        ],
      ),
    );
  }
}

class RegisterTest extends StatefulWidget {
  const RegisterTest({Key? key}) : super(key: key);

  @override
  State<RegisterTest> createState() => _RegisterTestState();
}

class _RegisterTestState extends State<RegisterTest> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exemplo',
        ),
        actions: const [Icon(Icons.abc)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomExpandedTile(
              title: 'teste',
              prefixIcon: Icons.trending_down,
              expandedItems: const [
                ExpandedItem(description: 'teste', value: 12.0),
                ExpandedItem(description: 'teste 2', value: 13.0),
                ExpandedItem(description: 'teste 2', value: 13.0)
              ],
              onButtonPressed: () {
                print('cliquei');
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ButtonGoogle(
                width: double.maxFinite,
                height: 52,
                onTap: () {
                  print('botao google');
                }),
            const SizedBox(
              height: 15,
            ),
            CustomOutlinedButton(
                buttonLabel: 'Exemplo',
                height: 52,
                width: double.maxFinite,
                onPressed: () async {
                  showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext ctx) {
                        return customAlertDialog(
                            context: context,
                            title: 'teste',
                            message: 'teste message',
                            informationColor: AppColors.informationErrorColor,
                            informationIcon: Icons.dangerous,
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'))
                            ]);
                      });
                }),
            const SizedBox(
              height: 15,
            ),
            CustomElevatedButton(
              buttonLabel: 'Exemplo',
              onPressed: () {},
              height: 52,
              width: double.maxFinite,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextFormField(
              labelText: 'Nome',
              readOnly: true,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextFormField(labelText: 'E-mail'),
            const SizedBox(
              height: 15,
            ),
            CustomTextFormField(labelText: 'Senha'),
            const SizedBox(
              height: 15,
            ),
            CustomDropDownButton(
                initialValue: 'olá',
                hintText: 'Exemplo',
                height: 52,
                width: double.maxFinite,
                items: const ['olá', 'alô', 'hello'],
                enabled: false,
                onChanged: (String? value) {})
          ],
        ),
      ),
    );
  }
}
