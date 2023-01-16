import 'package:dartz/dartz.dart';
import 'package:i_like_a_math/core/error/failure.dart';
import 'package:i_like_a_math/domain/entities/solution_entity.dart';


///
/// Repository's contract
///
abstract class SolutionRepository {
  Future<Either<Failure, SolutionEntity>> getSolution(int digit, int number);
}

