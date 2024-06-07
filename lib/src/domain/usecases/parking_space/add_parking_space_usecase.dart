import '../../../data/models/parking_space_dto.dart';
import '../../repositories/parking_space_repository.dart';

class AddParkingSpaceUsecase {
  final ParkingSpaceRepository _repository;

  AddParkingSpaceUsecase(ParkingSpaceRepository repository)
      : _repository = repository;

  Future<void> call(ParkingSpaceToCreateDTO space) async {
    return await _repository.addParkingSpace(space);
  }
}
