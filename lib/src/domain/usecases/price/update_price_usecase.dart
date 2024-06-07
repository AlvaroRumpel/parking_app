import '../../entities/price.dart';
import '../../repositories/price_repository.dart';

class UpdatePriceUsecase {
  final PriceRepository _repository;

  UpdatePriceUsecase({required PriceRepository repository})
      : _repository = repository;

  Future<void> call(Price price) async {
    await _repository.updatePrice(price);
  }
}
