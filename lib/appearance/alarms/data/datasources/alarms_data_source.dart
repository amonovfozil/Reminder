

class AlarmDataSource {
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
