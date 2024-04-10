import 'package:json_annotation/json_annotation.dart';
import 'package:meteo_sncf/data/weather/model/daytime_info.dart';
import 'package:meteo_sncf/data/weather/model/weather_conditions/clouds.dart';
import 'package:meteo_sncf/data/weather/model/weather_conditions/precipitation.dart';
import 'package:meteo_sncf/data/weather/model/weather_conditions/temp_pressure_conditions.dart';
import 'package:meteo_sncf/data/weather/model/weather_conditions/weather.dart';
import 'package:meteo_sncf/data/weather/model/weather_conditions/wind.dart';

part 'forecast_period.g.dart';

@JsonSerializable()
class ForecastPeriod {
  @JsonKey(name: 'dt')
  final int timestamp;

  /// Format : 2022-08-30 18:00:00
  @JsonKey(name: 'dt_txt')
  final String timestampText;
  @JsonKey(name: 'main')
  final TempPressureConditions tempPressureConditions;
  final List<Weather> weather;
  final Clouds? clouds;
  final Wind? wind;

  /// Unité : m, maximum : 10.000
  final int visibility;

  /// Pourcentage, entre 0 - 1
  @JsonKey(name: 'pop')
  final double precipProbability;
  final Precipitation? rain;
  final Precipitation? snow;
  @JsonKey(name: 'sys')
  final DaytimeInfo daytimeInfo;

  ForecastPeriod({
    required this.timestamp,
    required this.timestampText,
    required this.tempPressureConditions,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.precipProbability,
    required this.rain,
    required this.snow,
    required this.daytimeInfo,
  });

  factory ForecastPeriod.fromJson(Map<String, dynamic> json) =>
      _$ForecastPeriodFromJson(json);
}
