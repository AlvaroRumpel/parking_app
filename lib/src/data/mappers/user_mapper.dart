import '../../domain/entities/user.dart';
import '../models/user_dto.dart';

User userFromDTO(UserCompleteDTO dto) {
  return User(
    id: dto.id,
    email: dto.email,
    name: dto.email,
  );
}

UserDTO userToDTO(User user) {
  return UserCompleteDTO(
    id: user.id,
    name: user.name,
    email: user.email,
  );
}
