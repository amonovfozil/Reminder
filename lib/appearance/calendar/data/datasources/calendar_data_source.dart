// import 'package:dio/dio.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:reminder/core/constants/urls.dart';
// import '../../../../core/networking/dio_client.dart';
// import 'package:reminder/core/storage/app_storage.dart';
// import '../../../../core/providers/error/failures.dart';
// import '../../../../core/providers/service_locator.dart';

class CalendarDataSource {
  // Future<Either<Failure, ServiceSettingModel>> checkStatusService() async {
  //   try {
  //     final response = await sl<DioClient>().get(
  //       API.baseUrl,
  //       options: Options(
  //         headers: {"Authorization": "Bearer ${AppStorage.appToken}"},
  //       ),
  //     );
  //     return Right(ServiceSettingModel.fromJson(response.data['data']));
  //   } on DioException catch (e) {
  //     return Left(Failure(error: e));
  //   }
  // }
}
