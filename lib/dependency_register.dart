import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meteo_sncf/data/user/auth_repository.dart';
import 'package:meteo_sncf/data/user/user_network_repository.dart';
import 'package:meteo_sncf/data/weather/open_weather_repository.dart';
import 'package:meteo_sncf/service/get_forecast_for_city_uc.dart';
import 'package:meteo_sncf/service/sign_in_user_uc.dart';

class DependencyRegister {
  static Future register() async {
    final getIt = GetIt.instance;

    getIt.registerSingleton(Dio());
    getIt.registerSingleton(AuthRepository());
    getIt.registerSingleton(UserNetworkRepository());
    getIt.registerSingleton(OpenWeatherRepository());

    getIt.registerFactory(() => SignInUserUC());
    getIt.registerFactory(() => GetForecastForCityUC());

    return;
  }
}
