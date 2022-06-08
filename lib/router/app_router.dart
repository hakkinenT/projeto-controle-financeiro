import 'package:flutter/material.dart';

import '../screens/screens.dart';
import '../utils/utils.dart';

class AppRouter {
  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialPath:
        //return MaterialPageRoute(builder: (_) => const InitialPage());
        return MaterialPageRoute(builder: (_) => const HomePage());
      case loginPath:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case registerPath:
        return MaterialPageRoute(builder: (_) => const RegisterUserPage());
      case verifyEmailPath:
        return MaterialPageRoute(builder: (_) => const VerifyEmailPage());
      case homePath:
        return MaterialPageRoute(builder: (_) => const HomePage());
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
