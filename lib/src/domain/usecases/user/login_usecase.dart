import '../../../data/models/user_dto.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository _repository;

  LoginUsecase(AuthRepository repository) : _repository = repository;

  Future<User> call({required String email, required String password}) async {
    return _repository.login(UserToLoginDTO(email: email, password: password));
  }
}
