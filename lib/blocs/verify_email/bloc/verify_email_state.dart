part of 'verify_email_bloc.dart';

abstract class VerifyEmailState extends Equatable {
  final Email email;
  const VerifyEmailState({this.email = const Email.pure()});
  
  @override
  List<Object> get props => [];
}

class VerifyEmailInitial extends VerifyEmailState {}
