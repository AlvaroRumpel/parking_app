import '../models/parking_space_dto.dart';

abstract interface class ParkingSpaceDataSource {
  Future<List<ParkingSpaceCompleteDTO>> fetchParkingSpaces();
  Future<void> addParkingSpace(ParkingSpaceToCreateDTO space);
  Future<void> updateParkingSpace(ParkingSpaceCompleteDTO space);
  Future<void> deleteParkingSpace(int id);
}
