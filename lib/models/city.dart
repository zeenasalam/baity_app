import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable()
class CityModel {
  final String id;

  @JsonKey(readValue: _readNameValue)
  final String name;

  CityModel({
    required this.id,
    required this.name,
  });

  // Custom reader for the nested names field
  static Object? _readNameValue(Map map, String key) {
    return map['names']?['en-US'] ?? map['name'] ?? '';
  }

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}