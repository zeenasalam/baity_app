
class CityModel {
  final String id;
  final String name;

  CityModel({required this.id, required this.name});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] ?? '',
      name: json['names']?['en-US'] ?? json['name'] ?? '',
    );
  }
}