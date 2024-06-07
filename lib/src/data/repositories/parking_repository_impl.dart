import '../../domain/entities/parking_space.dart';
import '../../domain/repositories/parking_space_repository.dart';
import '../data_sources/parking_space_data_source.dart';
import '../mappers/parking_space_mapper.dart';
import '../models/parking_space_dto.dart';

class ParkingSpaceRepositoryImpl implements ParkingSpaceRepository {
  final ParkingSpaceDataSource dataSource;

  ParkingSpaceRepositoryImpl(this.dataSource);

  @override
  Future<List<ParkingSpace>> fetchParkingSpaces() async {
    final parkingSpacesDto = (await dataSource.fetchParkingSpaces())
        .map((e) => parkingSpaceFromDTO(e))
        .toList();
    return parkingSpacesDto;
  }

  @override
  Future<void> addParkingSpace(ParkingSpaceToCreateDTO space) =>
      dataSource.addParkingSpace(space);

  @override
  Future<void> updateParkingSpace(ParkingSpace space) =>
      dataSource.updateParkingSpace(parkingSpaceToDTO(space));

  @override
  Future<void> deleteParkingSpace(int id) => dataSource.deleteParkingSpace(id);
}
