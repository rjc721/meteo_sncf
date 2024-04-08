import 'package:json_annotation/json_annotation.dart';

part 'temp_pressure_conditions.g.dart';

@JsonSerializable()
class TempPressureConditions {
  final double temp;
  @JsonKey(name: 'feels_like')
  final double feelsLike;
  @JsonKey(name: 'temp_min')
  final double minTemperature;
  @JsonKey(name: 'temp_max')
  final double maxTemperature;

  /// Unité : hPa
  final double pressure;
  @JsonKey(name: 'sea_level')
  final double seaLevelPressure; // TODO: Inutile
  @JsonKey(name: 'grnd_level')
  final double groundLevelPressure; // TODO: Inutile
  final double humidity;
  @JsonKey(name: 'temp_kf')
  final double temp_kf; // TODO: Inutile

  TempPressureConditions({
    required this.temp,
    required this.feelsLike,
    required this.minTemperature,
    required this.maxTemperature,
    required this.pressure,
    required this.seaLevelPressure,
    required this.groundLevelPressure,
    required this.humidity,
    required this.temp_kf,
  });

  factory TempPressureConditions.fromJson(Map<String, dynamic> json) =>
      _$TempPressureConditionsFromJson(json);
}
