import '../../entities/price.dart';
import '../../repositories/price_repository.dart';

class FetchPriceUsecase {
  final PriceRepository _repository;

  FetchPriceUsecase({required PriceRepository repository})
      : _repository = repository;

  Future<Price> call() async {
    return await _repository.fetchPrice();
  }
}
