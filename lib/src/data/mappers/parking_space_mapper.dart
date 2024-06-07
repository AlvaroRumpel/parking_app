import '../../domain/entities/parking_space.dart';
import '../models/parking_space_dto.dart';

ParkingSpace parkingSpaceFromDTO(ParkingSpaceCompleteDTO dto) {
  return ParkingSpace(
    id: dto.id,
    isOccupied: dto.isOccupied,
    name: dto.name,
    startTime: dto.startTime,
    licensePlate: dto.licensePlate,
  );
}

ParkingSpaceCompleteDTO parkingSpaceToDTO(ParkingSpace entity) {
  return ParkingSpaceCompleteDTO(
    id: entity.id,
    isOccupied: entity.isOccupied,
    name: entity.name,
    licensePlate: entity.licensePlate,
    startTime: entity.startTime,
  );
}
