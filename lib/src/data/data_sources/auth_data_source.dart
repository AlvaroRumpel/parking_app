import '../models/user_dto.dart';

abstract interface class AuthDataSource {
  Future<void> login(UserToLoginDTO user);
  Future<UserCompleteDTO> fetchUserByEmail(String email);
  Future<void> isLogged();
}
