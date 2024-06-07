import 'custom_exception.dart';

class LoginException extends CustomException {
  LoginException(String message) : super(message, '');
}
