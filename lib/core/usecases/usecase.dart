import 'package:dartz/dartz.dart';
import 'package:i_like_a_math/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}