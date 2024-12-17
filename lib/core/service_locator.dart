import 'package:dio/dio.dart';
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
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));
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
        update: (context, repo, previous) =>
        previous ?? RealEstateBloc(repo),
      ),
    ];
  }
}