import 'package:json_annotation/json_annotation.dart';

part 'coords.g.dart';

@JsonSerializable()
class Coords {
  @JsonKey(name: 'lat')
  final double latitude;

  @JsonKey(name: 'lon')
  final double longitude;

  Coords({required this.latitude, required this.longitude});

  factory Coords.fromJson(Map<String, dynamic> json) => _$CoordsFromJson(json);
}