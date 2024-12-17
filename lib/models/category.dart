import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class CategoryModel {
  final String id;

  @JsonKey(readValue: _readNameValue)
  final String name;

  CategoryModel({
    required this.id,
    required this.name,
  });

  static Object? _readNameValue(Map map, String key) {
    return map['names']?['en-US'] ?? map['name'] ?? '';
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}