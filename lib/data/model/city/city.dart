import 'package:json_annotation/json_annotation.dart';
import 'package:meteo_sncf/data/model/city/coords.dart';

part 'city.g.dart';

@JsonSerializable()
class City {
  final int id;
  final String name;
  @JsonKey(name: 'coord')
  final Coords coordinates;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;

  City({
    required this.id,
    required this.name,
    required this.coordinates,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}
