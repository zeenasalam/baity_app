import 'category.dart';
import 'city.dart';

class RealEstateModel {
  final String id;
  final String title;
  final String ownerName;
  final String ownerImageUrl;
  final CityModel city;
  final CategoryModel category;
  final String offerType;
  final double price;
  final double area;
  final int? noOfRooms;
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

  factory RealEstateModel.fromJson(Map<String, dynamic> json) {
    return RealEstateModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      ownerName: json['ownerName'] ?? '',
      ownerImageUrl: json['ownerImageUrl'] ?? '',
      city: CityModel.fromJson(json['city'] ?? {}),
      category: CategoryModel.fromJson(json['category'] ?? {}),
      offerType: json['offerType'] ?? '',
      price: (json['price'] is num) ? json['price'].toDouble() : 0.0,
      area: (json['area'] is num) ? json['area'].toDouble() : 0.0,
      noOfRooms: json['noOfRooms'],
      district: json['district']?['name'],
    );
  }
}
