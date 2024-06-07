import '../../core/exceptions/exception.dart';
import '../../core/services/http/http_service.dart';
import '../../core/services/http/http_service_impl.dart';
import '../models/price_dto.dart';
import './price_data_source.dart';

class PriceDataSourceImpl implements PriceDataSource {
  final HttpService _client = HttpServiceImpl.i;

  final _endPoint = 'price';

  @override
  Future<PriceDTO> fetchPrice() async {
    try {
      final result = await _client.get(_endPoint);

      if (result.isEmpty) {
        throw RegisterNotFoundException('Nenhum preço encontrado!');
      }

      return PriceDTO.fromMap(result.first);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updatePrice(PriceDTO dto) async {
    try {
      await _client.put(_endPoint, 1, dto.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
