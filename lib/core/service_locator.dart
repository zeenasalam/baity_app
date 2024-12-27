import 'package:baity/blocs/get_realestate_cubit.dart';
import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/real_estate_bloc.dart';
import '../repository/realestate_repo.dart';

class ServiceLocator {
  static Future<List<SingleChildWidget>> setup() async {
    final prefs = await SharedPreferences.getInstance();
    final dio = Dio(BaseOptions(
      baseUrl: 'https://v3.ibaity.com/api/',
      connectTimeout: 10000,
      receiveTimeout: 10000,
    ));
    dio.interceptors.add(dioLoggerInterceptor);

    return [
      Provider<SharedPreferences>.value(value: prefs),
      Provider<Dio>.value(value: dio),
      ProxyProvider2<Dio, SharedPreferences, RealEstateRepository>(
        create: (context) => RealEstateRepository(
          context.read<Dio>(),
          context.read<SharedPreferences>(),
        ),
        update: (context, dio, prefs, previous) =>
            previous ?? RealEstateRepository(dio, prefs),
      ),
      ProxyProvider<RealEstateRepository, RealEstateBloc>(
        create: (context) => RealEstateBloc(
          context.read<RealEstateRepository>(),
        ),
        update: (context, repo, previous) => previous ?? RealEstateBloc(repo),
      ),
      ProxyProvider<RealEstateRepository, GetRealEstateCubit>(
        create: (context) => GetRealEstateCubit(
          context.read<RealEstateRepository>(),
        ),
        update: (context, repo, previous) =>
            previous ?? GetRealEstateCubit(repo),
      ),
    ];
  }
}
