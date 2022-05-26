import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/app.dart';
import 'package:projeto_controle_financeiro/di/setup_locator.dart';

import 'repositories/repositories.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();

  final authenticationRepository = getIt<AuthenticationRepository>();
  await authenticationRepository.user.first;
  runApp(App(
    authenticationRepository: authenticationRepository,
  ));
}
