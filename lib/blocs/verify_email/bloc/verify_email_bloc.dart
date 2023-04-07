import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:octopus/core/data/repositories/auth_repository.dart';
import 'package:octopus/validations/validation_value.dart';

part 'verify_email_event.dart';
part 'verify_email_state.dart';

@singleton
class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  final AuthRepository _authRepository;

  VerifyEmailBloc(this._authRepository) : super(VerifyEmailInitialState()) {
    on<VerifyEmailChanged>(_handleEmailChanged);
    on<VerifyEmailSubmited>(_handleSubmitted);
  }

  _handleEmailChanged(
      VerifyEmailChanged event, Emitter<VerifyEmailState> emit) {
    final email = Email.dirty(event.email);
    emit(VerifyEmailChangedState(email: email));
  }

  Future<void> _handleSubmitted(
      VerifyEmailSubmited event, Emitter<VerifyEmailState> emit) async {
    try {
      emit(VerifyEmailLoadingState());
      final verifyEmail = await _authRepository.verifyEmail(event.email);
      print(verifyEmail);
      if (verifyEmail.success) {
        emit(VerifyEmailSuccessState());
      } else {
        emit(VerifyEmailErrorState());
      }
    } catch (e) {
      emit(VerifyEmailErrorState());
    }
  }
}
