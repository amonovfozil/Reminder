// import 'package:fpdart/fpdart.dart';
// import '../../../../core/providers/error/failures.dart';
// import 'package:reminder/appearance/home/data/datasources/home_data_source.dart';
import 'package:reminder/appearance/remind/data/datasources/remind_data_source.dart';

abstract class RemindRepository {
  // Future<Either<Failure, ServiceSettingModel>> checkStatusService();
}

class RemindRepositoryImpl implements RemindRepository {
  final RemindDataSource dataSource;
  RemindRepositoryImpl({required this.dataSource});

  // @override
  // Future<Either<Failure, ServiceSettingModel>> checkStatusService() async {
  //   try {
  //     return await dataSource.checkStatusService();
  //   } on ServerException catch (e) {
  //     return left(Failure(error: e));
  //   }
  // }
}
