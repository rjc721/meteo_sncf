import 'package:meteo_sncf/service/model/city_forecast.dart';
import 'package:meteo_sncf/service/model/sncf_city.dart';

sealed class CityWeatherState {
  SNCFCity get selectedCity;
}

class CityWeatherInitial extends CityWeatherState {
  @override
  SNCFCity get selectedCity => SNCFCity.paris;
}

class CityWeatherLoadStarted extends CityWeatherState {
  @override
  final SNCFCity selectedCity;

  CityWeatherLoadStarted({required this.selectedCity});
}

class CityWeatherLoaded extends CityWeatherState {
  @override
  final SNCFCity selectedCity;
  final CityForecast cityForecast;

  CityWeatherLoaded({required this.selectedCity, required this.cityForecast});
}

class CityWeatherFailed extends CityWeatherState {
  @override
  final SNCFCity selectedCity;

  CityWeatherFailed({required this.selectedCity});
}
