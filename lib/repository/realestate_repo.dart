import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/category.dart';
import '../models/city.dart';
import '../models/realestate.dart';


class RealEstateRepository {
  final Dio _dio;
  final SharedPreferences _prefs;

  RealEstateRepository(this._dio, this._prefs);

  Future<List<RealEstateModel>> fetchRealEstates({
    String? cityId,
    String? categoryId,
    String? offerType,
    int pageSize = 10,
    int pageNumber = 1,
  }) async {
    try {
      final response = await _dio.get('client/Realestate', queryParameters: {
        if (cityId != null) 'CityId': cityId,
        if (categoryId != null) 'SubCategoryId': categoryId,
        if (offerType != null) 'OfferType': offerType,
        'PageSize': pageSize,
        'PageNumber': pageNumber,
      });

      if (response.data['payload'] is List) {
        return (response.data['payload'] as List)
            .map((json) => RealEstateModel.fromJson(json))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CityModel>> fetchCities() async {
    const cacheKey = 'cities_cache';

    // Try getting from cache first
    final cachedCities = _prefs.getString(cacheKey);
    if (cachedCities != null) {
      final List<dynamic> cachedList = json.decode(cachedCities);
      return cachedList.map((city) => CityModel.fromJson(city)).toList();
    }

    try {
      final response = await _dio.get('v1/dashboard/City');
      if (response.data['payload'] is List) {
        final cities = (response.data['payload'] as List)
            .map((json) => CityModel.fromJson(json))
            .toList();

        // Cache the result
        await _prefs.setString(cacheKey, json.encode(response.data['payload']));

        return cities;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    const cacheKey = 'categories_cache';

    // Try getting from cache first
    final cachedCategories = _prefs.getString(cacheKey);
    if (cachedCategories != null) {
      final List<dynamic> cachedList = json.decode(cachedCategories);
      return cachedList.map((category) => CategoryModel.fromJson(category)).toList();
    }

    try {
      final response = await _dio.get('dashboard/Category');
      if (response.data['payload'] is List) {
        final categories = (response.data['payload'] as List)
            .map((json) => CategoryModel.fromJson(json))
            .toList();

        // Cache the result
        await _prefs.setString(cacheKey, json.encode(response.data['payload']));

        return categories;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}