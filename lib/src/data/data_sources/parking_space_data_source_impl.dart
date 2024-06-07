import '../../core/exceptions/exception.dart';
import '../../core/services/http/http_service.dart';
import '../../core/services/http/http_service_impl.dart';
import '../models/parking_space_dto.dart';
import './parking_space_data_source.dart';

class ParkingSpaceDataSourceImpl implements ParkingSpaceDataSource {
  final HttpService _client = HttpServiceImpl.i;

  final _endPoint = 'parkingSpaces';

  @override
  Future<void> addParkingSpace(ParkingSpaceToCreateDTO space) async {
    try {
      await _client.post(_endPoint, space.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteParkingSpace(int id) async {
    try {
      await _client.delete(_endPoint, id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ParkingSpaceCompleteDTO>> fetchParkingSpaces() async {
    try {
      final result = await _client.get(_endPoint);

      if (result.isEmpty) {
        throw RegisterNotFoundException('Nenhum estacionamento encontrado!');
      }

      final parkingSpaces = result
          .map(
            (e) => ParkingSpaceCompleteDTO.fromMap(e),
          )
          .toList();

      return parkingSpaces;
    } on RegisterNotFoundException {
      rethrow;
    } catch (e) {
      throw CustomException('Erro ao buscar estacionamentos');
    }
  }

  @override
  Future<void> updateParkingSpace(ParkingSpaceCompleteDTO space) async {
    try {
      await _client.put(_endPoint, space.id, space.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
