import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/modules/userManagement/user_management.dart';

import 'modules/login/authentication/auth_service.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(hintText: 'Nome'),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Email'),
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
