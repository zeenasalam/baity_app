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
  final bool hasReachedMax;
  final int currentPage;

  const RealEstateState({
    this.realEstates = const [],
    this.isLoading = false,
    this.error,
    this.hasReachedMax = false,
    this.currentPage = 1,
  });

  RealEstateState copyWith({
    List<RealEstateModel>? realEstates,
    bool? isLoading,
    String? error,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return RealEstateState(
      realEstates: realEstates ?? this.realEstates,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [realEstates, isLoading, error, hasReachedMax, currentPage];
}

class LoadMoreRealEstatesEvent extends RealEstateEvent {}

class RealEstateBloc extends Bloc<RealEstateEvent, RealEstateState> {
  final RealEstateRepository _repository;
  static const int pageSize = 10;

  RealEstateBloc(this._repository) : super(const RealEstateState()) {
    on<FetchRealEstatesEvent>(_onFetchRealEstates);
    on<LoadMoreRealEstatesEvent>(_onLoadMoreRealEstates);
  }

  Future<void> _onFetchRealEstates(
      FetchRealEstatesEvent event,
      Emitter<RealEstateState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, currentPage: 1));

    try {
      final realEstates = await _repository.fetchRealEstates(
        cityId: event.cityId,
        categoryId: event.categoryId,
        offerType: event.offerType,
        pageSize: pageSize,
        pageNumber: 1,
      );

      final filteredRealEstates = event.searchQuery != null
          ? realEstates.where((estate) =>
      estate.ownerName.toLowerCase().contains(event.searchQuery!.toLowerCase()) ||
          estate.title.toLowerCase().contains(event.searchQuery!.toLowerCase()))
          .toList()
          : realEstates;

      emit(state.copyWith(
        realEstates: filteredRealEstates,
        isLoading: false,
        hasReachedMax: realEstates.length < pageSize,
      ));
    } catch (error) {
      emit(state.copyWith(
        error: error.toString(),
        isLoading: false,
      ));
    }
  }

  Future<void> _onLoadMoreRealEstates(
      LoadMoreRealEstatesEvent event,
      Emitter<RealEstateState> emit,
      ) async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(isLoading: true));

    try {
      final nextPage = state.currentPage + 1;
      final moreRealEstates = await _repository.fetchRealEstates(
        pageSize: pageSize,
        pageNumber: nextPage,
      );

      if (moreRealEstates.isEmpty) {
        emit(state.copyWith(
          hasReachedMax: true,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          realEstates: [...state.realEstates, ...moreRealEstates],
          currentPage: nextPage,
          isLoading: false,
          hasReachedMax: moreRealEstates.length < pageSize,
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        error: error.toString(),
        isLoading: false,
      ));
    }
  }
}