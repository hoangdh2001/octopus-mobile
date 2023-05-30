import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:jose/jose.dart';

/// Token designed to store the JWT and the user it is related to.
class TokenRaw extends Equatable {
  const TokenRaw._({
    required this.rawValue,
    required this.userId,
  });

  /// Creates a [TokenRaw] instance from the provided [rawValue] if it's valid.
  factory TokenRaw.fromRawValue(String rawValue) {
    final jwtBody = JsonWebToken.unverified(rawValue);
    final userId = jwtBody.claims.getTyped('id');
    assert(
      userId != null,
      'Invalid `token`, It should contain `user_id`',
    );
    return TokenRaw._(
      rawValue: rawValue,
      userId: userId!.toString(),
    );
  }

  /// Authentication type of this token

  /// String value of the token
  final String rawValue;

  /// User id associated with this token
  final String userId;

  @override
  List<Object?> get props => [rawValue, userId];
}
