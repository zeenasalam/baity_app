import 'package:baity/blocs/get_realestate_cubit.dart';
import 'package:baity/views/real_estate_screen.dart';
import 'package:baity/views/realestate_pagination_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'core/service_locator.dart';
import 'blocs/real_estate_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final providers = await ServiceLocator.setup();
  runApp(MultiProvider(
    providers: providers,
    child: const RealEstateApp(),
  ));
}

class RealEstateApp extends StatelessWidget {
  const RealEstateApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real Estate App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<RealEstateBloc>(
            create: (context) => context.read<RealEstateBloc>(),
            child: const RealestateScreen(),
          ),
          BlocProvider<GetRealEstateCubit>(
            create: (context) => context.read<GetRealEstateCubit>(),
          ),
        ],
        child: const RealestatePaginationScreen(),
      ),
    );
  }
}
