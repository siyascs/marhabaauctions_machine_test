import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../features/reels/data/datasource/reels_remote_data_source.dart';
import '../../features/reels/data/repositories/reel_repository._impl.dart';
import '../../features/reels/domain/repositories/reel_repository.dart';
import '../../features/reels/domain/usecases/get_reels.dart';
import '../../features/reels/presentation/bloc/reels_bloc.dart';
import '../network/api_client.dart';


final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => ApiClient(sl()));

  sl.registerLazySingleton<ReelsRemoteDataSource>(
          () => ReelsRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<ReelsRepository>(
          () => ReelsRepositoryImpl(sl()));

  sl.registerLazySingleton(() => GetReels(sl()));

  sl.registerFactory(() => ReelsBloc(sl()));
}
