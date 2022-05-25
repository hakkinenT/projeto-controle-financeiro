import 'package:get_it/get_it.dart';
import 'package:projeto_controle_financeiro/cache/cache.dart';

import 'package:projeto_controle_financeiro/repositories/authentication_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/register_user/register_user.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  await _initSharedPref();
  _initCache();
  _initAuthenticationRepository();
  _initRegisterUserCubit();
}

Future<void> _initSharedPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
}

void _initCache() {
  getIt.registerSingleton<Cache>(Cache(getIt<SharedPreferences>()));
}

void _initAuthenticationRepository() {
  getIt.registerSingleton<AuthenticationRepository>(AuthenticationRepository());
}

void _initRegisterUserCubit() {
  getIt.registerSingleton<RegisterUserCubit>(
      RegisterUserCubit(getIt<AuthenticationRepository>()));
}
