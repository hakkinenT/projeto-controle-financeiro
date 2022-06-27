import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/presentation/screens/income_page/income_page.dart';

import '../presentation/screens/screens.dart';
import '../utils/utils.dart';

class AppRouter {
  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case kInitialPath:
        return MaterialPageRoute(builder: (_) => const InitialPage());

      case kLoginPath:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case kRegisterPath:
        return MaterialPageRoute(builder: (_) => const RegisterUserPage());
      case kVerifyEmailPath:
        return MaterialPageRoute(builder: (_) => const VerifyEmailPage());
      case kHomePath:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case kRegisterIncomePath:
        return MaterialPageRoute(
            builder: (_) => const IncomePage(
                  income: null,
                  isDetailsPage: false,
                ));
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
