import 'package:baity/models/realestate.dart';
import 'package:baity/models/resault_state.dart';
import 'package:baity/repository/realestate_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetRealEstateCubit extends Cubit<ResultState<List<RealEstateModel>>> {
  GetRealEstateCubit(this._repository, ) : super(Idle());

  final RealEstateRepository _repository;

  Future<void> fetchRealEstates({
    required int pageNumber,
  }) async {
    emit(Loading());
    try {
      final x = await _repository.fetchRealEstates(
        pageNumber: pageNumber,
      );
      emit(Data(x));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
