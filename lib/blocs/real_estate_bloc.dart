import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/realestate.dart';
import '../repository/realestate_repo.dart';

abstract class RealEstateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchRealEstatesEvent extends RealEstateEvent {
  final String? cityId;
  final String? categoryId;
  final String? offerType;
  final String? searchQuery;

  FetchRealEstatesEvent({
    this.cityId,
    this.categoryId,
    this.offerType,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [cityId, categoryId, offerType, searchQuery];
}

class RealEstateState extends Equatable {
  final List<RealEstateModel> realEstates;
  final bool isLoading;
  final String? error;

  const RealEstateState({
    this.realEstates = const [],
    this.isLoading = false,
    this.error,
  });

  RealEstateState copyWith({
    List<RealEstateModel>? realEstates,
    bool? isLoading,
    String? error,
  }) {
    return RealEstateState(
      realEstates: realEstates ?? this.realEstates,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [realEstates, isLoading, error];
}

class RealEstateBloc extends Bloc<RealEstateEvent, RealEstateState> {
  final RealEstateRepository _repository;

  RealEstateBloc(this._repository) : super(const RealEstateState()) {
    on<FetchRealEstatesEvent>(_onFetchRealEstates);
  }

  Future<void> _onFetchRealEstates(
      FetchRealEstatesEvent event,
      Emitter<RealEstateState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final realEstates = await _repository.fetchRealEstates(
        cityId: event.cityId,
        categoryId: event.categoryId,
        offerType: event.offerType,
      );

      final filteredRealEstates = event.searchQuery != null
          ? realEstates.where((estate) =>
      estate.ownerName.toLowerCase().contains(event.searchQuery!.toLowerCase()) ||
          estate.title.toLowerCase().contains(event.searchQuery!.toLowerCase())
      ).toList()
          : realEstates;

      emit(state.copyWith(
        realEstates: filteredRealEstates,
        isLoading: false,
      ));
    } catch (error) {
      emit(state.copyWith(
        error: error.toString(),
        isLoading: false,
      ));
    }
  }
}