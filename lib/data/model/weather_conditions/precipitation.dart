import 'package:json_annotation/json_annotation.dart';

part 'precipitation.g.dart';

@JsonSerializable()
class Precipitation {
  /// Volume for last 3 hours, unité : mm
  @JsonKey(name: '3h')
  final double threeH;

  Precipitation(this.threeH);

  factory Precipitation.fromJson(Map<String, dynamic> json) =>
      _$PrecipitationFromJson(json);
}
