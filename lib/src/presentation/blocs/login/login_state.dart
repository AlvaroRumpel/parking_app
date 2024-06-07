part of 'login_cubit.dart';

@immutable
sealed class LoginState {
  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(User user) success,
    required T Function(String message) error,
  }) {
    if (this is LoginInitial) {
      return initial();
    } else if (this is LoginLoading) {
      return loading();
    } else if (this is LoginError) {
      return error((this as LoginError).message);
    }
    throw Exception('Unreachable');
  }

  T? maybeWhen<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(User user)? success,
    T Function(String message)? error,
    required T? Function() orElse,
  }) {
    if (this is LoginInitial && initial != null) {
      return initial();
    } else if (this is LoginLoading && loading != null) {
      return loading();
    } else if (this is LoginSuccess && success != null) {
      return success((this as LoginSuccess).user);
    } else if (this is LoginError && error != null) {
      return error((this as LoginError).message);
    } else {
      return orElse();
    }
  }

  T? whenOrNull<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(User user)? success,
    T Function(String message)? error,
  }) {
    return maybeWhen(
      initial: initial,
      loading: loading,
      success: success,
      error: error,
      orElse: () => null,
    );
  }
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess({required this.user});
}

final class LoginError extends LoginState {
  final String message;

  LoginError({required this.message});
}
