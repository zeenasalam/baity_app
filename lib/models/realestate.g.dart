// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realestate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealEstateModel _$RealEstateModelFromJson(Map<String, dynamic> json) =>
    RealEstateModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      ownerName: json['ownerName'] as String? ?? '',
      ownerImageUrl: json['ownerImageUrl'] as String? ?? '',
      city:
          RealEstateModel._cityFromJson(json['city'] as Map<String, dynamic>?),
      category: RealEstateModel._categoryFromJson(
          json['category'] as Map<String, dynamic>?),
      offerType: json['offerType'] as String? ?? '',
      price: RealEstateModel._doubleFromJson(json['price']),
      area: RealEstateModel._doubleFromJson(json['area']),
      noOfRooms: (json['noOfRooms'] as num?)?.toInt(),
      district: RealEstateModel._readDistrictValue(json, 'district') as String?,
    );

Map<String, dynamic> _$RealEstateModelToJson(RealEstateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'ownerName': instance.ownerName,
      'ownerImageUrl': instance.ownerImageUrl,
      'city': instance.city,
      'category': instance.category,
      'offerType': instance.offerType,
      'price': instance.price,
      'area': instance.area,
      'noOfRooms': instance.noOfRooms,
      'district': instance.district,
    };
