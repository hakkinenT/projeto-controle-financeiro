import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/app.dart';

void main() async {
  _init();
  runApp(const App());
}

void _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}
