import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'core/service_locator.dart';
import 'blocs/real_estate_bloc.dart';
import 'views/real_estate_list_page.dart';

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
      home: BlocProvider(
        create: (context) => context.read<RealEstateBloc>(),
        child: const RealEstateListPage(),
      ),
    );
  }
}