import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/modules/login/implementation/authentication/auth_service.dart';

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
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  try {
                    UserModel? userModel = await AuthService()
                        .signInWithEmailAndPassword(
                            'thol_16@hotmail.com', '12345678');
                    if (userModel != null) {
                      // ignore: avoid_print
                      print(userModel.uid);
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
                child: const Text('Logout from Google'))
          ],
        ),
      ),
    );
  }
}
