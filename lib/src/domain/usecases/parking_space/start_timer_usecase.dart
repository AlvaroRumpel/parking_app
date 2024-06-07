import '../../entities/parking_space.dart';
import '../../repositories/parking_space_repository.dart';

class StartTimerUsecase {
  final ParkingSpaceRepository _repository;

  StartTimerUsecase(ParkingSpaceRepository repository)
      : _repository = repository;

  Future<void> call(ParkingSpace space) async {
    final updatedSpace = space.copyWith(
      startTime: DateTime.now(),
    );

    return _repository.updateParkingSpace(updatedSpace);
  }
}
