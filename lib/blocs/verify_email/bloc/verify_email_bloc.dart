import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:octopus/validations/validation_value.dart';

part 'verify_email_event.dart';
part 'verify_email_state.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  VerifyEmailBloc() : super(VerifyEmailInitial()) {
    on<VerifyEmailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
