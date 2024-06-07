import '../../data/models/user_dto.dart';
import '../entities/user.dart';

abstract interface class AuthRepository {
  Future<User> login(UserToLoginDTO user);
  Future<bool> isLogged();
}
