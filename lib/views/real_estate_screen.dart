import 'package:baity/blocs/get_realestate_cubit.dart';
import 'package:baity/models/realestate.dart';
import 'package:baity/models/resault_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RealestateScreen extends StatefulHookWidget {
  const RealestateScreen({super.key});

  @override
  State<RealestateScreen> createState() => _RealestateScreenState();
}

class _RealestateScreenState extends State<RealestateScreen> {
  late GetRealEstateCubit _cubit;
  @override
  void initState() {
    _cubit = context.read<GetRealEstateCubit>();
    _cubit.fetchRealEstates(pageNumber: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('data'),
        ),
        body:
            BlocBuilder<GetRealEstateCubit, ResultState<List<RealEstateModel>>>(
                builder: (context, state) {
          switch (state) {
            case Loading<List<RealEstateModel>>():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Idle<List<RealEstateModel>>():
              return const Text('no data');
            case Error<List<RealEstateModel>>():
              return const Text('no data');
            case Data<List<RealEstateModel>>():
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.network(
                        state.data[index].ownerImageUrl,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported),
                      ),
                    ),
                    title: Text(state.data[index].id),
                    subtitle: Text(state.data[index].title),
                  );
                },
                itemCount: state.data.length,
              );
          }
        }));
  }
}
