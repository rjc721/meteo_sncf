import 'package:json_annotation/json_annotation.dart';
import 'package:meteo_sncf/data/weather/model/city/city.dart';
import 'package:meteo_sncf/data/weather/model/forecast_period.dart';

part 'five_day_forecast.g.dart';

@JsonSerializable()
class FiveDayForecast {
  @JsonKey(name: 'cod')
  final String code;
  final int message;
  @JsonKey(name: 'cnt')
  final int count;
  @JsonKey(name: 'list')
  final List<ForecastPeriod> periodList;
  final City city;

  FiveDayForecast({
    required this.code,
    required this.message,
    required this.count,
    required this.periodList,
    required this.city,
  });

  factory FiveDayForecast.fromJson(Map<String, dynamic> json) =>
      _$FiveDayForecastFromJson(json);
}
