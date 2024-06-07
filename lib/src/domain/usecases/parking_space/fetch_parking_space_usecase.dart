import '../../entities/parking_space.dart';
import '../../repositories/parking_space_repository.dart';

class FetchParkingSpacesUsecase {
  final ParkingSpaceRepository _repository;

  FetchParkingSpacesUsecase(ParkingSpaceRepository repository)
      : _repository = repository;

  Future<List<ParkingSpace>> call() async {
    return await _repository.fetchParkingSpaces();
  }
}
