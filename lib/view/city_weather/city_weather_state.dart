import 'package:meteo_sncf/service/model/city_forecast.dart';

sealed class CityWeatherState {}

class CityWeatherLoadStarted extends CityWeatherState {}

class CityWeatherLoaded extends CityWeatherState {
  final CityForecast cityForecast;
  CityWeatherLoaded({required this.cityForecast});
}

class CityWeatherFailed extends CityWeatherState {}
