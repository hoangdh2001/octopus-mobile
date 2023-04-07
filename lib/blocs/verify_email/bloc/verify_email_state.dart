part of 'verify_email_bloc.dart';

abstract class VerifyEmailState extends Equatable {
  @override
  List<Object> get props => [];
}

class VerifyEmailInitialState extends VerifyEmailState {}

class VerifyEmailChangedState extends VerifyEmailState {
  final Email email;

  VerifyEmailChangedState({this.email = const Email.pure()});

  VerifyEmailChangedState copyWith({Email? email}) {
    return VerifyEmailChangedState(email: email ?? this.email);
  }

  @override
  List<Object> get props => [email];
}

class VerifyEmailSuccessState extends VerifyEmailState {}

class VerifyEmailErrorState extends VerifyEmailState {}

class VerifyEmailLoadingState extends VerifyEmailState {}
