import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/real_estate_bloc.dart';
import '../repository/realestate_repo.dart';

class ServiceLocator {
  static final GetIt _getIt = GetIt.instance;

  static Future<void> setup() async {
    // Shared Preferences
    final prefs = await SharedPreferences.getInstance();
    _getIt.registerSingleton<SharedPreferences>(prefs);

    // Dio
    final dio = Dio(BaseOptions(
      baseUrl: 'https://v3.ibaity.com/api/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    _getIt.registerSingleton<Dio>(dio);

    // Repository
    _getIt.registerFactory<RealEstateRepository>(
          () => RealEstateRepository(_getIt<Dio>(), _getIt<SharedPreferences>()),
    );

    // BLoC
    _getIt.registerFactory<RealEstateBloc>(
          () => RealEstateBloc(_getIt<RealEstateRepository>()),
    );
  }

  static T get<T extends Object>() => _getIt<T>();
}