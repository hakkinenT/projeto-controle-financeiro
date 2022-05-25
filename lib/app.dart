import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_controle_financeiro/bloc/app_bloc.dart';

import 'package:projeto_controle_financeiro/repositories/authentication_repository.dart';
import 'package:projeto_controle_financeiro/router/app_router.dart';

import 'package:projeto_controle_financeiro/themes/app_theme.dart';

import 'cubit/register_user/register_user.dart';

class App extends StatelessWidget {
  const App(
      {Key? key, required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              AppBloc(authenticationRepository: _authenticationRepository),
        ),
        BlocProvider(
            create: (_) => RegisterUserCubit(_authenticationRepository))
      ],
      child: AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  AppView({Key? key}) : super(key: key);

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
