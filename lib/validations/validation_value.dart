import 'package:formz/formz.dart';
import 'package:octopus/core/extensions/extension_string.dart';

enum EmailValidationError { invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String? value) {
    return value?.isValidEmail == true ? null : EmailValidationError.invalid;
  }
}

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);
  @override
  PasswordValidationError? validator(String value) {
    return value.isValidPassword == true
        ? null
        : PasswordValidationError.invalid;
  }
}
