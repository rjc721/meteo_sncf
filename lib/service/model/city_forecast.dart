import 'package:meteo_sncf/service/model/weather_day.dart';

class CityForecast {
  final String cityName;
  final List<WeatherDay> weatherDays;

  CityForecast({
    required this.cityName,
    required this.weatherDays,
  });
}
