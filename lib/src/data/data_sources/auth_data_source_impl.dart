import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exceptions/exception.dart';
import '../../core/services/http/http_service.dart';
import '../../core/services/http/http_service_impl.dart';
import '../models/auth_dto.dart';
import '../models/user_dto.dart';
import 'auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final HttpService _client = HttpServiceImpl.i;

  final _endPoint = 'users';

  @override
  Future<void> login(UserToLoginDTO user) async {
    try {
      final responseLogin = await _client.post('auth', user.toMap());

      final authDto = AuthDto.fromMap(responseLogin.first);
      final sp = await SharedPreferences.getInstance();

      sp.setString('accessToken', authDto.accessToken);
      sp.setString('refreshToken', authDto.refreshToken);
    } catch (e) {
      throw LoginException('Erro ao fazer o login, tente novamente');
    }
  }

  @override
  Future<UserCompleteDTO> fetchUserByEmail(String email) async {
    try {
      final response = await _client.get('$_endPoint?email=$email');
      final userDto = UserCompleteDTO.fromMap(response.first);

      return userDto;
    } catch (e) {
      throw RegisterNotFoundException('Usuário não encontrado!');
    }
  }

  @override
  Future<void> isLogged() async {
    try {
      final sp = await SharedPreferences.getInstance();

      final accessToken = sp.getString('accessToken');

      if (accessToken == null || accessToken.isEmpty) {
        throw LoginException('Usuário não logado');
      }
    } catch (e) {
      rethrow;
    }
  }
}
