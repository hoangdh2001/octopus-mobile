
import 'package:dartz/dartz.dart';

class NetWorkResponse<L, R> extends Either<L, R> {
  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) {
    throw UnimplementedError();
  }
}