import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/screens/inital_page/initial_page.dart';
import 'package:projeto_controle_financeiro/utils/constants/routes_names.dart';

class AppRouter {
  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialPath:
        return MaterialPageRoute(builder: (_) => const InitialPage());
      case loginPath:
        break;
      case registerPath:
        break;
      case verifyEmailPath:
        break;
      case homePath:
        break;
      case registerIncomePath:
        break;
      case detailIncomePath:
        break;
      case registerExpensesPath:
        break;
      case detailExpensesPath:
        break;
      default:
        return null;
    }
    return null;
  }
}
