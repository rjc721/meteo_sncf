import 'package:json_annotation/json_annotation.dart';

part 'clouds.g.dart';

@JsonSerializable()
class Clouds {
  /// Percentage 0-100
  @JsonKey(name: 'all')
  final int cloudinessPercentage;

  Clouds({required this.cloudinessPercentage});

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);
}
