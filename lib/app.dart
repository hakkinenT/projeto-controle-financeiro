import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/modules/userManagement/user_management.dart';
import 'package:projeto_controle_financeiro/themes/app_typograph.dart';
import 'package:projeto_controle_financeiro/themes/app_theme.dart';

import 'modules/login/authentication/auth_service.dart';
import 'themes/app_colors.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const RegisterTest(),
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
            SizedBox(
                height: 55,
                width: double.maxFinite,
                child:
                    OutlinedButton(onPressed: () {}, child: Text('Exemplo'))),
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                  hintText: 'Nome',
                  hintStyle: AppTypograph.hintText,
                  label: Text(
                    'Nome',
                    style: AppTypograph.labelText,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  filled: true,
                  fillColor: const Color.fromRGBO(31, 170, 0, 0.1),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  alignLabelWithHint: true,
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  errorBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.informationErrorColor),
                      borderRadius: BorderRadius.all(Radius.circular(8)))),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(hintText: 'Senha'),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  UserModel? userModel = await UserManagement()
                      .registrationWithEmailAndPassword(nomeController.text,
                          emailController.text, passwordController.text);

                  if (userModel != null) {
                    print(userModel.displayName);
                    print(userModel.email);
                  } else {
                    print('é nulo');
                  }
                },
                child: const Text('Registrar'))
          ],
        ),
      ),
    );
  }
}
