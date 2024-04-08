import 'dart:math';
import 'package:meteo_sncf/service/model/weather_reading.dart';

class WeatherDay {
  final DateTime date;
  final List<WeatherReading> weatherReadings;

  int get maxTemp => weatherReadings.map((e) => e.maxTemp).reduce(max);

  int get minTemp => weatherReadings.map((e) => e.maxTemp).reduce(min);

  WeatherDay({required this.date, required this.weatherReadings});
}
