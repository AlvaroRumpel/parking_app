import '../entities/price.dart';

abstract interface class PriceRepository {
  Future<Price> fetchPrice();
  Future<void> updatePrice(Price price);
}
