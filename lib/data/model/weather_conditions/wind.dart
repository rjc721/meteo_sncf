import 'package:json_annotation/json_annotation.dart';

part 'wind.g.dart';

@JsonSerializable()
class Wind {
  final double speed;
  @JsonKey(name: 'deg')
  final double windDirectionDegrees;
  final double gust;

  Wind({
    required this.speed,
    required this.windDirectionDegrees,
    required this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);
}
