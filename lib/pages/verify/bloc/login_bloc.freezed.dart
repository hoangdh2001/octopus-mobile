// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) initial,
    required TResult Function(String email, String otp) loginWithOTP,
    required TResult Function(String email, String password) loginWithPass,
    required TResult Function() showOTPField,
    required TResult Function(String email) resendCode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? initial,
    TResult? Function(String email, String otp)? loginWithOTP,
    TResult? Function(String email, String password)? loginWithPass,
    TResult? Function()? showOTPField,
    TResult? Function(String email)? resendCode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? initial,
    TResult Function(String email, String otp)? loginWithOTP,
    TResult Function(String email, String password)? loginWithPass,
    TResult Function()? showOTPField,
    TResult Function(String email)? resendCode,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(LoginWithOTP value) loginWithOTP,
    required TResult Function(LoginWithPass value) loginWithPass,
    required TResult Function(ShowOTPField value) showOTPField,
    required TResult Function(ResendCode value) resendCode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(LoginWithOTP value)? loginWithOTP,
    TResult? Function(LoginWithPass value)? loginWithPass,
    TResult? Function(ShowOTPField value)? showOTPField,
    TResult? Function(ResendCode value)? resendCode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(LoginWithOTP value)? loginWithOTP,
    TResult Function(LoginWithPass value)? loginWithPass,
    TResult Function(ShowOTPField value)? showOTPField,
    TResult Function(ResendCode value)? resendCode,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginEventCopyWith<$Res> {
  factory $LoginEventCopyWith(
          LoginEvent value, $Res Function(LoginEvent) then) =
      _$LoginEventCopyWithImpl<$Res, LoginEvent>;
}

/// @nodoc
class _$LoginEventCopyWithImpl<$Res, $Val extends LoginEvent>
    implements $LoginEventCopyWith<$Res> {
  _$LoginEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialCopyWith<$Res> {
  factory _$$InitialCopyWith(_$Initial value, $Res Function(_$Initial) then) =
      __$$InitialCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$InitialCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$Initial>
    implements _$$InitialCopyWith<$Res> {
  __$$InitialCopyWithImpl(_$Initial _value, $Res Function(_$Initial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$Initial(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Initial implements Initial {
  const _$Initial(this.email);

  @override
  final String email;

  @override
  String toString() {
    return 'LoginEvent.initial(email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Initial &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialCopyWith<_$Initial> get copyWith =>
      __$$InitialCopyWithImpl<_$Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) initial,
    required TResult Function(String email, String otp) loginWithOTP,
    required TResult Function(String email, String password) loginWithPass,
    required TResult Function() showOTPField,
    required TResult Function(String email) resendCode,
  }) {
    return initial(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? initial,
    TResult? Function(String email, String otp)? loginWithOTP,
    TResult? Function(String email, String password)? loginWithPass,
    TResult? Function()? showOTPField,
    TResult? Function(String email)? resendCode,
  }) {
    return initial?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? initial,
    TResult Function(String email, String otp)? loginWithOTP,
    TResult Function(String email, String password)? loginWithPass,
    TResult Function()? showOTPField,
    TResult Function(String email)? resendCode,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(LoginWithOTP value) loginWithOTP,
    required TResult Function(LoginWithPass value) loginWithPass,
    required TResult Function(ShowOTPField value) showOTPField,
    required TResult Function(ResendCode value) resendCode,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(LoginWithOTP value)? loginWithOTP,
    TResult? Function(LoginWithPass value)? loginWithPass,
    TResult? Function(ShowOTPField value)? showOTPField,
    TResult? Function(ResendCode value)? resendCode,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(LoginWithOTP value)? loginWithOTP,
    TResult Function(LoginWithPass value)? loginWithPass,
    TResult Function(ShowOTPField value)? showOTPField,
    TResult Function(ResendCode value)? resendCode,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements LoginEvent {
  const factory Initial(final String email) = _$Initial;

  String get email;
  @JsonKey(ignore: true)
  _$$InitialCopyWith<_$Initial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginWithOTPCopyWith<$Res> {
  factory _$$LoginWithOTPCopyWith(
          _$LoginWithOTP value, $Res Function(_$LoginWithOTP) then) =
      __$$LoginWithOTPCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String otp});
}

/// @nodoc
class __$$LoginWithOTPCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$LoginWithOTP>
    implements _$$LoginWithOTPCopyWith<$Res> {
  __$$LoginWithOTPCopyWithImpl(
      _$LoginWithOTP _value, $Res Function(_$LoginWithOTP) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? otp = null,
  }) {
    return _then(_$LoginWithOTP(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginWithOTP implements LoginWithOTP {
  const _$LoginWithOTP(this.email, this.otp);

  @override
  final String email;
  @override
  final String otp;

  @override
  String toString() {
    return 'LoginEvent.loginWithOTP(email: $email, otp: $otp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginWithOTP &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.otp, otp) || other.otp == otp));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, otp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginWithOTPCopyWith<_$LoginWithOTP> get copyWith =>
      __$$LoginWithOTPCopyWithImpl<_$LoginWithOTP>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) initial,
    required TResult Function(String email, String otp) loginWithOTP,
    required TResult Function(String email, String password) loginWithPass,
    required TResult Function() showOTPField,
    required TResult Function(String email) resendCode,
  }) {
    return loginWithOTP(email, otp);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? initial,
    TResult? Function(String email, String otp)? loginWithOTP,
    TResult? Function(String email, String password)? loginWithPass,
    TResult? Function()? showOTPField,
    TResult? Function(String email)? resendCode,
  }) {
    return loginWithOTP?.call(email, otp);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? initial,
    TResult Function(String email, String otp)? loginWithOTP,
    TResult Function(String email, String password)? loginWithPass,
    TResult Function()? showOTPField,
    TResult Function(String email)? resendCode,
    required TResult orElse(),
  }) {
    if (loginWithOTP != null) {
      return loginWithOTP(email, otp);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(LoginWithOTP value) loginWithOTP,
    required TResult Function(LoginWithPass value) loginWithPass,
    required TResult Function(ShowOTPField value) showOTPField,
    required TResult Function(ResendCode value) resendCode,
  }) {
    return loginWithOTP(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(LoginWithOTP value)? loginWithOTP,
    TResult? Function(LoginWithPass value)? loginWithPass,
    TResult? Function(ShowOTPField value)? showOTPField,
    TResult? Function(ResendCode value)? resendCode,
  }) {
    return loginWithOTP?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(LoginWithOTP value)? loginWithOTP,
    TResult Function(LoginWithPass value)? loginWithPass,
    TResult Function(ShowOTPField value)? showOTPField,
    TResult Function(ResendCode value)? resendCode,
    required TResult orElse(),
  }) {
    if (loginWithOTP != null) {
      return loginWithOTP(this);
    }
    return orElse();
  }
}

abstract class LoginWithOTP implements LoginEvent {
  const factory LoginWithOTP(final String email, final String otp) =
      _$LoginWithOTP;

  String get email;
  String get otp;
  @JsonKey(ignore: true)
  _$$LoginWithOTPCopyWith<_$LoginWithOTP> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginWithPassCopyWith<$Res> {
  factory _$$LoginWithPassCopyWith(
          _$LoginWithPass value, $Res Function(_$LoginWithPass) then) =
      __$$LoginWithPassCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$LoginWithPassCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$LoginWithPass>
    implements _$$LoginWithPassCopyWith<$Res> {
  __$$LoginWithPassCopyWithImpl(
      _$LoginWithPass _value, $Res Function(_$LoginWithPass) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$LoginWithPass(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginWithPass implements LoginWithPass {
  const _$LoginWithPass(this.email, this.password);

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginEvent.loginWithPass(email: $email, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginWithPass &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginWithPassCopyWith<_$LoginWithPass> get copyWith =>
      __$$LoginWithPassCopyWithImpl<_$LoginWithPass>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) initial,
    required TResult Function(String email, String otp) loginWithOTP,
    required TResult Function(String email, String password) loginWithPass,
    required TResult Function() showOTPField,
    required TResult Function(String email) resendCode,
  }) {
    return loginWithPass(email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? initial,
    TResult? Function(String email, String otp)? loginWithOTP,
    TResult? Function(String email, String password)? loginWithPass,
    TResult? Function()? showOTPField,
    TResult? Function(String email)? resendCode,
  }) {
    return loginWithPass?.call(email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? initial,
    TResult Function(String email, String otp)? loginWithOTP,
    TResult Function(String email, String password)? loginWithPass,
    TResult Function()? showOTPField,
    TResult Function(String email)? resendCode,
    required TResult orElse(),
  }) {
    if (loginWithPass != null) {
      return loginWithPass(email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(LoginWithOTP value) loginWithOTP,
    required TResult Function(LoginWithPass value) loginWithPass,
    required TResult Function(ShowOTPField value) showOTPField,
    required TResult Function(ResendCode value) resendCode,
  }) {
    return loginWithPass(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(LoginWithOTP value)? loginWithOTP,
    TResult? Function(LoginWithPass value)? loginWithPass,
    TResult? Function(ShowOTPField value)? showOTPField,
    TResult? Function(ResendCode value)? resendCode,
  }) {
    return loginWithPass?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(LoginWithOTP value)? loginWithOTP,
    TResult Function(LoginWithPass value)? loginWithPass,
    TResult Function(ShowOTPField value)? showOTPField,
    TResult Function(ResendCode value)? resendCode,
    required TResult orElse(),
  }) {
    if (loginWithPass != null) {
      return loginWithPass(this);
    }
    return orElse();
  }
}

abstract class LoginWithPass implements LoginEvent {
  const factory LoginWithPass(final String email, final String password) =
      _$LoginWithPass;

  String get email;
  String get password;
  @JsonKey(ignore: true)
  _$$LoginWithPassCopyWith<_$LoginWithPass> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShowOTPFieldCopyWith<$Res> {
  factory _$$ShowOTPFieldCopyWith(
          _$ShowOTPField value, $Res Function(_$ShowOTPField) then) =
      __$$ShowOTPFieldCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ShowOTPFieldCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$ShowOTPField>
    implements _$$ShowOTPFieldCopyWith<$Res> {
  __$$ShowOTPFieldCopyWithImpl(
      _$ShowOTPField _value, $Res Function(_$ShowOTPField) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ShowOTPField implements ShowOTPField {
  const _$ShowOTPField();

  @override
  String toString() {
    return 'LoginEvent.showOTPField()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ShowOTPField);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) initial,
    required TResult Function(String email, String otp) loginWithOTP,
    required TResult Function(String email, String password) loginWithPass,
    required TResult Function() showOTPField,
    required TResult Function(String email) resendCode,
  }) {
    return showOTPField();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? initial,
    TResult? Function(String email, String otp)? loginWithOTP,
    TResult? Function(String email, String password)? loginWithPass,
    TResult? Function()? showOTPField,
    TResult? Function(String email)? resendCode,
  }) {
    return showOTPField?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? initial,
    TResult Function(String email, String otp)? loginWithOTP,
    TResult Function(String email, String password)? loginWithPass,
    TResult Function()? showOTPField,
    TResult Function(String email)? resendCode,
    required TResult orElse(),
  }) {
    if (showOTPField != null) {
      return showOTPField();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(LoginWithOTP value) loginWithOTP,
    required TResult Function(LoginWithPass value) loginWithPass,
    required TResult Function(ShowOTPField value) showOTPField,
    required TResult Function(ResendCode value) resendCode,
  }) {
    return showOTPField(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(LoginWithOTP value)? loginWithOTP,
    TResult? Function(LoginWithPass value)? loginWithPass,
    TResult? Function(ShowOTPField value)? showOTPField,
    TResult? Function(ResendCode value)? resendCode,
  }) {
    return showOTPField?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(LoginWithOTP value)? loginWithOTP,
    TResult Function(LoginWithPass value)? loginWithPass,
    TResult Function(ShowOTPField value)? showOTPField,
    TResult Function(ResendCode value)? resendCode,
    required TResult orElse(),
  }) {
    if (showOTPField != null) {
      return showOTPField(this);
    }
    return orElse();
  }
}

abstract class ShowOTPField implements LoginEvent {
  const factory ShowOTPField() = _$ShowOTPField;
}

/// @nodoc
abstract class _$$ResendCodeCopyWith<$Res> {
  factory _$$ResendCodeCopyWith(
          _$ResendCode value, $Res Function(_$ResendCode) then) =
      __$$ResendCodeCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$ResendCodeCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$ResendCode>
    implements _$$ResendCodeCopyWith<$Res> {
  __$$ResendCodeCopyWithImpl(
      _$ResendCode _value, $Res Function(_$ResendCode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$ResendCode(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ResendCode implements ResendCode {
  const _$ResendCode(this.email);

  @override
  final String email;

  @override
  String toString() {
    return 'LoginEvent.resendCode(email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResendCode &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResendCodeCopyWith<_$ResendCode> get copyWith =>
      __$$ResendCodeCopyWithImpl<_$ResendCode>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) initial,
    required TResult Function(String email, String otp) loginWithOTP,
    required TResult Function(String email, String password) loginWithPass,
    required TResult Function() showOTPField,
    required TResult Function(String email) resendCode,
  }) {
    return resendCode(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? initial,
    TResult? Function(String email, String otp)? loginWithOTP,
    TResult? Function(String email, String password)? loginWithPass,
    TResult? Function()? showOTPField,
    TResult? Function(String email)? resendCode,
  }) {
    return resendCode?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? initial,
    TResult Function(String email, String otp)? loginWithOTP,
    TResult Function(String email, String password)? loginWithPass,
    TResult Function()? showOTPField,
    TResult Function(String email)? resendCode,
    required TResult orElse(),
  }) {
    if (resendCode != null) {
      return resendCode(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(LoginWithOTP value) loginWithOTP,
    required TResult Function(LoginWithPass value) loginWithPass,
    required TResult Function(ShowOTPField value) showOTPField,
    required TResult Function(ResendCode value) resendCode,
  }) {
    return resendCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(LoginWithOTP value)? loginWithOTP,
    TResult? Function(LoginWithPass value)? loginWithPass,
    TResult? Function(ShowOTPField value)? showOTPField,
    TResult? Function(ResendCode value)? resendCode,
  }) {
    return resendCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(LoginWithOTP value)? loginWithOTP,
    TResult Function(LoginWithPass value)? loginWithPass,
    TResult Function(ShowOTPField value)? showOTPField,
    TResult Function(ResendCode value)? resendCode,
    required TResult orElse(),
  }) {
    if (resendCode != null) {
      return resendCode(this);
    }
    return orElse();
  }
}

abstract class ResendCode implements LoginEvent {
  const factory ResendCode(final String email) = _$ResendCode;

  String get email;
  @JsonKey(ignore: true)
  _$$ResendCodeCopyWith<_$ResendCode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LoginState {
  String get email => throw _privateConstructorUsedError;
  bool get isShow => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  Option<String> get passwordError => throw _privateConstructorUsedError;
  Option<Either<Token, Error>> get successOfFail =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call(
      {String email,
      bool isShow,
      bool isLoading,
      Option<String> passwordError,
      Option<Either<Token, Error>> successOfFail});
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? isShow = null,
    Object? isLoading = null,
    Object? passwordError = null,
    Object? successOfFail = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      isShow: null == isShow
          ? _value.isShow
          : isShow // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      passwordError: null == passwordError
          ? _value.passwordError
          : passwordError // ignore: cast_nullable_to_non_nullable
              as Option<String>,
      successOfFail: null == successOfFail
          ? _value.successOfFail
          : successOfFail // ignore: cast_nullable_to_non_nullable
              as Option<Either<Token, Error>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LoginStateCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$$_LoginStateCopyWith(
          _$_LoginState value, $Res Function(_$_LoginState) then) =
      __$$_LoginStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      bool isShow,
      bool isLoading,
      Option<String> passwordError,
      Option<Either<Token, Error>> successOfFail});
}

/// @nodoc
class __$$_LoginStateCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$_LoginState>
    implements _$$_LoginStateCopyWith<$Res> {
  __$$_LoginStateCopyWithImpl(
      _$_LoginState _value, $Res Function(_$_LoginState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? isShow = null,
    Object? isLoading = null,
    Object? passwordError = null,
    Object? successOfFail = null,
  }) {
    return _then(_$_LoginState(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      isShow: null == isShow
          ? _value.isShow
          : isShow // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      passwordError: null == passwordError
          ? _value.passwordError
          : passwordError // ignore: cast_nullable_to_non_nullable
              as Option<String>,
      successOfFail: null == successOfFail
          ? _value.successOfFail
          : successOfFail // ignore: cast_nullable_to_non_nullable
              as Option<Either<Token, Error>>,
    ));
  }
}

/// @nodoc

class _$_LoginState implements _LoginState {
  const _$_LoginState(
      {required this.email,
      required this.isShow,
      required this.isLoading,
      required this.passwordError,
      required this.successOfFail});

  @override
  final String email;
  @override
  final bool isShow;
  @override
  final bool isLoading;
  @override
  final Option<String> passwordError;
  @override
  final Option<Either<Token, Error>> successOfFail;

  @override
  String toString() {
    return 'LoginState(email: $email, isShow: $isShow, isLoading: $isLoading, passwordError: $passwordError, successOfFail: $successOfFail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginState &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.isShow, isShow) || other.isShow == isShow) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.passwordError, passwordError) ||
                other.passwordError == passwordError) &&
            (identical(other.successOfFail, successOfFail) ||
                other.successOfFail == successOfFail));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, email, isShow, isLoading, passwordError, successOfFail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoginStateCopyWith<_$_LoginState> get copyWith =>
      __$$_LoginStateCopyWithImpl<_$_LoginState>(this, _$identity);
}

abstract class _LoginState implements LoginState {
  const factory _LoginState(
          {required final String email,
          required final bool isShow,
          required final bool isLoading,
          required final Option<String> passwordError,
          required final Option<Either<Token, Error>> successOfFail}) =
      _$_LoginState;

  @override
  String get email;
  @override
  bool get isShow;
  @override
  bool get isLoading;
  @override
  Option<String> get passwordError;
  @override
  Option<Either<Token, Error>> get successOfFail;
  @override
  @JsonKey(ignore: true)
  _$$_LoginStateCopyWith<_$_LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}
