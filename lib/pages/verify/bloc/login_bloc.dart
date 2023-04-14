import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:octopus/core/data/models/error.dart';
import 'package:octopus/core/data/models/token.dart';
import 'package:octopus/core/data/repositories/auth_repository.dart';
import 'package:octopus/utils/constants.dart';

part 'login_bloc.freezed.dart';

@singleton
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  final FlutterSecureStorage secureStorage;

  LoginBloc(this._authRepository, this.secureStorage)
      : super(LoginState.initial()) {
    on<LoginEvent>((event, emit) async {
      await event.map(
        initial: (value) async {
          emit(LoginState.initial(email: value.email));
        },
        loginWithOTP: (value) async {
          await _handleLoginWithOtp(value, emit);
        },
        loginWithPass: (value) async {
          await _handleLoginWithPass(value, emit);
        },
        showOTPField: (value) async {
          emit(state.copyWith(isShow: true, successOfFail: none()));
        },
        resendCode: (value) async {
          await _authRepository.sendEmail(value.email);
        },
      );
    });
  }

  Future<void> _handleLoginWithOtp(
      LoginWithOTP event, Emitter<LoginState> emitter) async {
    emitter(state.copyWith(
        isLoading: true, successOfFail: none(), passwordError: none()));
    final result = await _authRepository.loginWithOTP(event.email, event.otp);
    emitter(
      result.fold(
        (token) {
          return state.copyWith(
              isLoading: false, successOfFail: some(left(token)));
        },
        (error) {
          return state.copyWith(
              isLoading: false, successOfFail: some(right(error)));
        },
      ),
    );
  }

  Future<void> _handleLoginWithPass(
      LoginWithPass event, Emitter<LoginState> emitter) async {
    emitter(state.copyWith(
        isLoading: true, successOfFail: none(), passwordError: none()));
    final result =
        await _authRepository.loginWithPass(event.email, event.password);
    emitter(
      result.fold(
        (token) {
          return state.copyWith(
              isLoading: false,
              successOfFail: some(left(token)),
              passwordError: none());
        },
        (error) {
          return state.copyWith(
              isLoading: false,
              successOfFail: some(right(error)),
              passwordError: some('Password error'));
        },
      ),
    );
  }

  Future<void> handleStorageToken(Token token) async {
    await secureStorage.write(
        key: octopusToken, value: jsonEncode(token.toJson()));
  }
}

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.initial(String email) = Initial;
  const factory LoginEvent.loginWithOTP(String email, String otp) =
      LoginWithOTP;
  const factory LoginEvent.loginWithPass(String email, String password) =
      LoginWithPass;
  const factory LoginEvent.showOTPField() = ShowOTPField;

  const factory LoginEvent.resendCode(String email) = ResendCode;
}

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required String email,
    required bool isShow,
    required bool isLoading,
    required Option<String> passwordError,
    required Option<Either<Token, Error>> successOfFail,
  }) = _LoginState;

  factory LoginState.initial({String? email}) => LoginState(
      email: email ?? '',
      isShow: false,
      isLoading: false,
      passwordError: none(),
      successOfFail: none());
}
