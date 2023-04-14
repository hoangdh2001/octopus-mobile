import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:octopus/core/data/models/error.dart';
import 'package:octopus/core/data/models/sign_up_request.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/repositories/auth_repository.dart';
import 'package:octopus/validations/validation_value.dart';

part 'sign_up_bloc.freezed.dart';

@singleton
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository _authRepository;

  SignUpBloc(this._authRepository) : super(SignUpState.initial()) {
    on<SignUpEvent>((event, emit) async {
      await event.map(
        init: (value) async {
          emit(state.copyWith(email: value.email));
        },
        firstNameChanged: (FirstNameChanged value) async {
          emit(
            state.copyWith(
              firstName: value.firstName,
              passwordError: none(),
              confirmPasswordError: none(),
            ),
          );
        },
        lastNameChanged: (value) async {
          emit(state.copyWith(
              lastName: value.lastName,
              passwordError: none(),
              confirmPasswordError: none()));
        },
        passwordChanged: (PasswordChanged value) async {
          emit(state.copyWith(
              password: Password.dirty(value.password),
              passwordError: none(),
              confirmPasswordError: none()));
        },
        confirmPasswordChanged: (ConfirmPasswordChanged value) async {
          emit(state.copyWith(
              confirmPassword: Password.dirty(value.confirmPassword),
              passwordError: none(),
              confirmPasswordError: none()));
        },
        submitted: (value) async {
          await _handleSubmitted(state, emit);
        },
      );
    });
  }

  Future<void> _handleSubmitted(
      SignUpState state, Emitter<SignUpState> emit) async {
    if (state.password.isNotValid) {
      emit(state.copyWith(passwordError: some('Mật khẩu phải hơn 8 ký tự')));
    } else if (state.password.value.compareTo(state.confirmPassword.value) !=
        0) {
      emit(state.copyWith(confirmPasswordError: some('Mật khẩu không khớp')));
    } else {
      emit(state.copyWith(isSubmitting: true, successOrFail: none()));
      final rs = await _authRepository.signUp(SignUpRequest(
        email: state.email,
        firstName: state.firstName,
        lastName: state.lastName,
        password: state.password.value,
      ));
      emit(
        rs.fold(
          (user) {
            return state.copyWith(
              isSubmitting: false,
              successOrFail: some(left(user)),
              firstName: '',
              lastName: '',
              passwordError: none(),
              confirmPasswordError: none(),
              password: const Password.pure(),
              confirmPassword: const Password.pure(),
            );
          },
          (error) {
            return state.copyWith(
              isSubmitting: false,
              successOrFail: some(right(error)),
              firstName: '',
              lastName: '',
              password: const Password.pure(),
              confirmPassword: const Password.pure(),
            );
          },
        ),
      );
    }
  }
}

@freezed
class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.init(String email) = Init;
  const factory SignUpEvent.firstNameChanged(String firstName) =
      FirstNameChanged;
  const factory SignUpEvent.lastNameChanged(String lastName) = LastNameChanged;
  const factory SignUpEvent.passwordChanged(String password) = PasswordChanged;
  const factory SignUpEvent.confirmPasswordChanged(String confirmPassword) =
      ConfirmPasswordChanged;
  const factory SignUpEvent.submitted() = Submitted;
}

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    required String email,
    required String firstName,
    required String lastName,
    required Password password,
    required Password confirmPassword,
    required Option<String> passwordError,
    required Option<String> confirmPasswordError,
    required bool isSubmitting,
    required Option<Either<User, Error>> successOrFail,
  }) = _SignUpState;

  factory SignUpState.initial() => SignUpState(
        email: '',
        firstName: '',
        lastName: '',
        password: const Password.pure(),
        confirmPassword: const Password.pure(),
        passwordError: none(),
        confirmPasswordError: none(),
        isSubmitting: false,
        successOrFail: none(),
      );
}
