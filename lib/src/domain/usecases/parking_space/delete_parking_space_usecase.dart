import '../../repositories/parking_space_repository.dart';

class DeleteParkingSpaceUsecase {
  final ParkingSpaceRepository _repository;

  DeleteParkingSpaceUsecase(ParkingSpaceRepository repository)
      : _repository = repository;

  Future<void> call(int id) async {
    return await _repository.deleteParkingSpace(id);
  }
}
