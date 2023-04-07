part of 'verify_email_bloc.dart';

abstract class VerifyEmailEvent extends Equatable {
  const VerifyEmailEvent();

  @override
  List<Object> get props => [];
}

class VerifyEmailChanged extends VerifyEmailEvent {
  final String email;

  const VerifyEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class VerifyEmailSubmited extends VerifyEmailEvent {
  final String email;

  const VerifyEmailSubmited(this.email);

  @override
  List<Object> get props => [email];
}
