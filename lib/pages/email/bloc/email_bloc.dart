import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:octopus/core/data/models/enums/verification_type.dart';
import 'package:octopus/core/data/models/error.dart';
import 'package:octopus/core/data/models/verify_email.dart';
import 'package:octopus/core/data/repositories/auth_repository.dart';
import 'package:octopus/validations/validation_value.dart';

part 'email_bloc.freezed.dart';

@singleton
class EmailBloc extends Bloc<EmailEvent, EmailState> {
  final AuthRepository _authRepository;

  EmailBloc(this._authRepository) : super(EmailState.initial()) {
    on<EmailEvent>((event, emit) async {
      await event.map(emailChanged: (EmailChanged value) async {
        emit(state.copyWith(
            email: Email.dirty(value.email), successOrFail: none()));
      }, submitted: (Submitted value) async {
        await _handleSubmitted(state, emit);
      });
    });
  }

  Future<void> _handleSubmitted(
      EmailState state, Emitter<EmailState> emit) async {
    emit(state.copyWith(isSubmitting: true, successOrFail: none()));
    final result = await _authRepository.sendEmail(state.email.value);
    emit(result.fold((verifyEmail) {
      return state.copyWith(
          isSubmitting: false, successOrFail: some(left(verifyEmail)));
    },
        (error) => state.copyWith(
            isSubmitting: false, successOrFail: some(right(error)))));
  }
}

@freezed
class EmailEvent with _$EmailEvent {
  const factory EmailEvent.emailChanged(String email) = EmailChanged;
  const factory EmailEvent.submitted() = Submitted;
}

@freezed
class EmailState with _$EmailState {
  const factory EmailState({
    required Email email,
    required bool isSubmitting,
    required Option<Either<VerifyEmail, Error>> successOrFail,
  }) = _EmailState;

  factory EmailState.initial() => EmailState(
        email: const Email.pure(),
        isSubmitting: false,
        successOrFail: none(),
      );
}
