import 'dart:convert';

class UserDTO {
  final String email;
  UserDTO({
    required this.email,
  });
}

class UserToLoginDTO extends UserDTO {
  final String password;

  UserToLoginDTO({
    required this.password,
    required super.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'email': email,
    };
  }

  String toJson() => json.encode(toMap());
}

class UserCompleteDTO extends UserDTO {
  final int id;
  final String name;

  UserCompleteDTO({
    required super.email,
    required this.id,
    required this.name,
  });

  factory UserCompleteDTO.fromMap(Map<String, dynamic> map) {
    return UserCompleteDTO(
      id: map['id']?.toInt(),
      name: map['name'],
      email: map['email'],
    );
  }

  factory UserCompleteDTO.fromJson(String source) =>
      UserCompleteDTO.fromMap(json.decode(source));
}
