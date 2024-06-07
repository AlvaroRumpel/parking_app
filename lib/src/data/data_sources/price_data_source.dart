import '../models/price_dto.dart';

abstract interface class PriceDataSource {
  Future<PriceDTO> fetchPrice();
  Future<void> updatePrice(PriceDTO dto);
}
