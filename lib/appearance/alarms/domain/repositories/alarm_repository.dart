// import 'package:fpdart/fpdart.dart';
// import '../../../../core/providers/error/failures.dart';
// import 'package:reminder/appearance/home/data/datasources/home_data_source.dart';
import 'package:reminder/appearance/calendar/data/datasources/calendar_data_source.dart';

abstract class AlarmRepository {
  // Future<Either<Failure, ServiceSettingModel>> checkStatusService();
}

class AlarmRepositoryImpl implements AlarmRepository {
  final CalendarDataSource dataSource;
  AlarmRepositoryImpl({required this.dataSource});

  // @override
  // Future<Either<Failure, ServiceSettingModel>> checkStatusService() async {
  //   try {
  //     return await dataSource.checkStatusService();
  //   } on ServerException catch (e) {
  //     return left(Failure(error: e));
  //   }
  // }
}
