import 'package:get_it/get_it.dart';
import '../networking/dio_client.dart';

final sl = GetIt.instance;

void setupsl() {
  _initHome();
  sl.registerLazySingleton<DioClient>(() => DioClient());
}

void _initHome() {
  // sl
  //   ..registerFactory<AuthDataSource>(() => AuthDataSourceImpl())
  //   ..registerFactory<AuthRepository>(() => AuthRepositoryImpl());
}
