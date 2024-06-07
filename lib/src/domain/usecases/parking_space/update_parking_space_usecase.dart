import '../../entities/parking_space.dart';
import '../../repositories/parking_space_repository.dart';

class UpdateParkingSpaceUsecase {
  final ParkingSpaceRepository _repository;

  UpdateParkingSpaceUsecase(ParkingSpaceRepository repository)
      : _repository = repository;

  Future<void> call(ParkingSpace space) async {
    return await _repository.updateParkingSpace(space);
  }
}
