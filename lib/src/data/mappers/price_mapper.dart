import '../../domain/entities/price.dart';
import '../models/price_dto.dart';

Price priceFromDTO(PriceDTO dto) {
  return Price(price: dto.price);
}

PriceDTO priceToDTO(Price price) {
  return PriceDTO(price: price.price);
}
