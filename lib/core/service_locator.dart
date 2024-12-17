import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/real_estate_bloc.dart';
import '../repository/realestate_repo.dart';

class ServiceLocator {
  static final GetIt _getIt = GetIt.instance;

  static Future<void> setup() async {
    final prefs = await SharedPreferences.getInstance();
    _getIt.registerSingleton<SharedPreferences>(prefs);

    final dio = Dio(BaseOptions(
      baseUrl: 'https://v3.ibaity.com/api/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    )
    );

    _getIt.registerSingleton<Dio>(dio);
    _getIt.registerFactory<RealEstateRepository>(
          () => RealEstateRepository(_getIt<Dio>(), _getIt<SharedPreferences>()),
    );
    _getIt.registerFactory<RealEstateBloc>(
          () => RealEstateBloc(_getIt<RealEstateRepository>()),
    );
  }

  static T get<T extends Object>() => _getIt<T>();
}