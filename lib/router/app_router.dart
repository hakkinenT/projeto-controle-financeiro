import 'package:flutter/material.dart';

import '../presentation/screens/screens.dart';
import '../utils/utils.dart';

class AppRouter {
  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case kInitialPath:
        return MaterialPageRoute(builder: (_) => const InitialPage());
      //return MaterialPageRoute(builder: (_) => const HomePage());
      case kLoginPath:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case kRegisterPath:
        return MaterialPageRoute(builder: (_) => const RegisterUserPage());
      case kVerifyEmailPath:
        return MaterialPageRoute(builder: (_) => const VerifyEmailPage());
      case kHomePath:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case kRegisterIncomePath:
        break;
      case kDetailIncomePath:
        break;
      case kRegisterExpensesPath:
        break;
      case kDetailExpensesPath:
        break;
      default:
        return null;
    }
    return null;
  }
}
