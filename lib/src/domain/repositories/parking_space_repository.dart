import '../../data/models/parking_space_dto.dart';
import '../entities/parking_space.dart';

abstract class ParkingSpaceRepository {
  Future<List<ParkingSpace>> fetchParkingSpaces();
  Future<void> addParkingSpace(ParkingSpaceToCreateDTO space);
  Future<void> updateParkingSpace(ParkingSpace space);
  Future<void> deleteParkingSpace(int id);
}
