import 'package:fpdart/fpdart.dart';
import '../../data/models/servise_setting_model.dart';
import '../../../../core/providers/error/failures.dart';
import 'package:reminder/appearance/home/data/datasources/home_datasource.dart';

abstract class HomeRepository {
  Future<Either<Failure, ServiceSettingModel>> checkStatusService();
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource dataSource;
  HomeRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, ServiceSettingModel>> checkStatusService() async {
    try {
      return await dataSource.checkStatusService();
    } on ServerException catch (e) {
      return left(Failure(error: e));
    }
  }
}
