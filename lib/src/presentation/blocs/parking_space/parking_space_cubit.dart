import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../core/exceptions/exception.dart';
import '../../../core/extensions/extensions.dart';
import '../../../data/mappers/parking_space_mapper.dart';
import '../../../data/models/parking_space_dto.dart';
import '../../../domain/entities/price.dart';
import '../../../domain/usecases/parking_space/parking_space_usecase.dart';
import '../../../domain/usecases/price/price_usecase.dart';

part 'parking_space_state.dart';

class ParkingSpaceCubit extends Cubit<ParkingSpaceState> {
  final AddParkingSpaceUsecase _addUsecase;
  final FetchParkingSpacesUsecase _fetchUsecase;
  final DeleteParkingSpaceUsecase _deleteUsecase;
  final UpdateParkingSpaceUsecase _updateUsecase;
  final CalculatePriceUsecase _calculatePriceUsecase;
  final StartTimerUsecase _startTimerUsecase;
  final StopTimerUsecase _stopTimerUsecase;
  final UpdatePriceUsecase _updatePriceUsecase;
  final FetchPriceUsecase _fetchPriceUsecase;

  var actualPrice = 5.0;

  ParkingSpaceCubit({
    required AddParkingSpaceUsecase addUsecase,
    required FetchParkingSpacesUsecase fetchUsecase,
    required DeleteParkingSpaceUsecase deleteUsecase,
    required UpdateParkingSpaceUsecase updateUsecase,
    required CalculatePriceUsecase calculatePriceUsecase,
    required StartTimerUsecase startTimerUsecase,
    required StopTimerUsecase stopTimerUsecase,
    required UpdatePriceUsecase updatePriceUsecase,
    required FetchPriceUsecase fetchPriceUsecase,
  })  : _updateUsecase = updateUsecase,
        _deleteUsecase = deleteUsecase,
        _fetchUsecase = fetchUsecase,
        _addUsecase = addUsecase,
        _calculatePriceUsecase = calculatePriceUsecase,
        _startTimerUsecase = startTimerUsecase,
        _stopTimerUsecase = stopTimerUsecase,
        _updatePriceUsecase = updatePriceUsecase,
        _fetchPriceUsecase = fetchPriceUsecase,
        super(ParkingSpaceInitial()) {
    fetchParkingSpaces();
  }

  Future<void> fetchParkingSpaces() async {
    try {
      emit(ParkingSpaceLoading());

      final result = (await _fetchUsecase())
          .map(
            (e) => parkingSpaceToDTO(e),
          )
          .toList();

      emit(ParkingSpaceData(parkingSpace: result));
    } on RegisterNotFoundException {
      emit(ParkingSpaceEmpty());
    } catch (e) {
      emit(ParkingSpaceError(message: e.toString()));
    }
  }

  Future<void> addParkingSpace(
    String name,
    bool isOccupied,
    String? licensePlate,
  ) async {
    try {
      emit(ParkingSpaceLoading());

      if (isOccupied && (licensePlate == null || licensePlate.isEmpty)) {
        throw CustomException('Placa do veiculo precisa de identificação');
      }

      final startTime = isOccupied ? DateTime.now() : null;

      await _addUsecase(
        ParkingSpaceToCreateDTO(
          name: name,
          isOccupied: isOccupied,
          startTime: startTime,
          licensePlate: licensePlate,
        ),
      );

      await fetchParkingSpaces();
    } catch (e) {
      emit(ParkingSpaceError(message: e.toString()));
    }
  }

  Future<void> editParkingSpace(
    ParkingSpaceCompleteDTO space,
    String name,
    bool isOccupied,
    String? licensePlate,
  ) async {
    try {
      emit(ParkingSpaceLoading());

      final dto = space.copyWith(
        name: name,
        isOccupied: isOccupied,
        licensePlate: licensePlate?.toLicensePlate(),
      );

      await _updateUsecase(parkingSpaceFromDTO(dto));

      if (dto.isOccupied) {
        await startTimer(dto);
      }

      await fetchParkingSpaces();
    } catch (e) {
      emit(ParkingSpaceError(message: e.toString()));
    }
  }

  Future<void> startTimer(ParkingSpaceCompleteDTO dto) async {
    await _startTimerUsecase(parkingSpaceFromDTO(dto));
  }

  Future<void> releaseParkingSpace(ParkingSpaceCompleteDTO dto) async {
    try {
      emit(ParkingSpaceLoading());

      await _stopTimerUsecase(parkingSpaceFromDTO(dto));
      final price = _calculatePriceUsecase(
        dto.startTime!,
        DateTime.now(),
        actualPrice,
      );

      if (price > 0) {
        emit(ParkingSpacePrice(price: price));
      }

      await fetchParkingSpaces();
    } catch (e) {
      emit(ParkingSpaceError(message: e.toString()));
    }
  }

  Future<void> deleteParkingSpace(ParkingSpaceCompleteDTO space) async {
    try {
      emit(ParkingSpaceLoading());

      await _deleteUsecase(space.id);

      await fetchParkingSpaces();
    } catch (e) {
      emit(ParkingSpaceError(message: e.toString()));
    }
  }

  Future<void> updatePrice(double value) async {
    try {
      final parkingSpaces = state.maybeWhen(
        data: (spaces) => spaces,
        orElse: () {},
      );

      emit(ParkingSpaceLoading());

      await _updatePriceUsecase(Price(price: value));

      actualPrice = (await _fetchPriceUsecase()).price;

      if (parkingSpaces != null) {
        emit(ParkingSpaceData(parkingSpace: parkingSpaces));
        return;
      }

      fetchParkingSpaces();
    } catch (e) {
      emit(ParkingSpaceError(message: e.toString()));
    }
  }
}
