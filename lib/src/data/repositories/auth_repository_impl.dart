import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_data_source.dart';
import '../mappers/user_mapper.dart';
import '../models/user_dto.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<User> login(UserToLoginDTO user) async {
    await authDataSource.login(user);
    return userFromDTO(await authDataSource.fetchUserByEmail(user.email));
  }

  @override
  Future<bool> isLogged() async {
    try {
      await authDataSource.isLogged();
      return true;
    } catch (e) {
      return false;
    }
  }
}
