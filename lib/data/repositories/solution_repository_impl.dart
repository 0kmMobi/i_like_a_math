import 'package:i_like_a_math/core/error/exception.dart';
import 'package:i_like_a_math/core/error/failure.dart';
import 'package:i_like_a_math/data/data_sources/solution_data_source.dart';
import 'package:i_like_a_math/data/models/solution_model.dart';
import 'package:i_like_a_math/domain/entities/solution_entity.dart';
import 'package:i_like_a_math/domain/repositories/solution_repository.dart';
import 'package:dartz/dartz.dart';

class SolutionRepositoryImpl implements SolutionRepository {
  final SolutionDataSource dataSource;

  SolutionRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, SolutionEntity>> getSolution(int digit, int number) async {
    return await _getSolution(() async {
      return await dataSource.getSolution(digit, number);
    });
  }

  Future<Either<Failure, SolutionModel>> _getSolution(
      Future<SolutionModel> Function() getPersons) async {
      try {
        final solution = await getPersons();
        return Right(solution);
      } on DataSourceException catch (e){
        return Left(DataSourceFailure(e.msg));
      }
  }
}