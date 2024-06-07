import '../../entities/parking_space.dart';
import '../../repositories/parking_space_repository.dart';

class StopTimerUsecase {
  final ParkingSpaceRepository _repository;

  StopTimerUsecase(ParkingSpaceRepository repository)
      : _repository = repository;

  Future<void> call(ParkingSpace space) async {
    final updatedSpace = space.copyWithReleaseSpace(isOccupied: false);

    return _repository.updateParkingSpace(updatedSpace);
  }
}
