import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../business_logic/business_logic.dart';
import '../data/cache/cache.dart';
import '../data/repositories/repositories.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  await _initSharedPref();
  _initCache();
  _initAuthenticationRepository();
  //_initRegisterUserCubit();
  //_initLoginCubit();
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

/*void _initRegisterUserCubit() {
  getIt.registerSingleton<RegisterUserCubit>(
      RegisterUserCubit(getIt<AuthenticationRepository>()));
}

void _initLoginCubit() {
  getIt.registerSingleton<LoginCubit>(
      LoginCubit(getIt<AuthenticationRepository>()));
}*/
