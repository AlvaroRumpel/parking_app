import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/user/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase _loginUseCase;

  LoginCubit(LoginUsecase loginUseCase)
      : _loginUseCase = loginUseCase,
        super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    try {
      emit(LoginLoading());

      final user = await _loginUseCase(email: email, password: password);

      emit(LoginSuccess(user: user));
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }
}
