import 'package:audioplayers/audioplayers.dart';
import 'package:get_it/get_it.dart';
import 'package:i_like_a_math/domain/repositories/solution_repository.dart';

import 'data/data_sources/solution_data_source.dart';
import 'data/repositories/solution_repository_impl.dart';
import 'domain/usecases/get_solution.dart';
import 'presentation/bloc/home_page_digit_cubit.dart';


final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(() => AudioPlayer()
    ..setPlayerMode(PlayerMode.lowLatency)
    ..setReleaseMode(ReleaseMode.release)
  );

  sl.registerLazySingleton<SolutionDataSource>(() => SolutionDataSourceImpl());
  sl.registerLazySingleton<SolutionRepository>(() => SolutionRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<GetSolution>(() => GetSolution(sl()));
  sl.registerLazySingleton<DigitAndNumberCubit>(() => DigitAndNumberCubit(getSolution: sl()));
}