import 'package:json_annotation/json_annotation.dart';

part 'daytime_info.g.dart';

@JsonSerializable()
class DaytimeInfo {
  @JsonKey(name: 'pod')
  final PartOfDay partOfDay;

  DaytimeInfo(this.partOfDay);

  factory DaytimeInfo.fromJson(Map<String, dynamic> json) =>
      _$DaytimeInfoFromJson(json);
}

enum PartOfDay {
  @JsonValue('d')
  day,
  @JsonValue('n')
  night;
}
