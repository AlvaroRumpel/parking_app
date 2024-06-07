import '../../domain/entities/price.dart';
import '../../domain/repositories/price_repository.dart';
import '../data_sources/price_data_source.dart';
import '../mappers/price_mapper.dart';

class PriceRepositoryImpl implements PriceRepository {
  final PriceDataSource dataSource;

  PriceRepositoryImpl(this.dataSource);

  @override
  Future<Price> fetchPrice() async {
    final price = await dataSource.fetchPrice();

    return priceFromDTO(price);
  }

  @override
  Future<void> updatePrice(Price price) =>
      dataSource.updatePrice(priceToDTO(price));
}
