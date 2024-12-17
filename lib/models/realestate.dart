import 'package:json_annotation/json_annotation.dart';
import 'category.dart';
import 'city.dart';

part 'realestate.g.dart';

@JsonSerializable()
class RealEstateModel {
  @JsonKey(defaultValue: '')
  final String id;

  @JsonKey(defaultValue: '')
  final String title;

  @JsonKey(defaultValue: '')
  final String ownerName;

  @JsonKey(defaultValue: '')
  final String ownerImageUrl;

  @JsonKey(fromJson: _cityFromJson)
  final CityModel city;

  @JsonKey(fromJson: _categoryFromJson)
  final CategoryModel category;

  @JsonKey(defaultValue: '')
  final String offerType;

  @JsonKey(fromJson: _doubleFromJson)
  final double price;

  @JsonKey(fromJson: _doubleFromJson)
  final double area;

  final int? noOfRooms;

  @JsonKey(readValue: _readDistrictValue)
  final String? district;

  RealEstateModel({
    required this.id,
    required this.title,
    required this.ownerName,
    required this.ownerImageUrl,
    required this.city,
    required this.category,
    required this.offerType,
    required this.price,
    required this.area,
    this.noOfRooms,
    this.district,
  });

  static double _doubleFromJson(dynamic value) {
    if (value == null) return 0.0;
    return value is num ? value.toDouble() : 0.0;
  }

  static CityModel _cityFromJson(Map<String, dynamic>? json) {
    return CityModel.fromJson(json ?? {});
  }

  static CategoryModel _categoryFromJson(Map<String, dynamic>? json) {
    return CategoryModel.fromJson(json ?? {});
  }

  static Object? _readDistrictValue(Map map, String key) {
    return map['district']?['name'];
  }

  factory RealEstateModel.fromJson(Map<String, dynamic> json) =>
      _$RealEstateModelFromJson(json);

  Map<String, dynamic> toJson() => _$RealEstateModelToJson(this);
}