import 'package:fpdart/fpdart.dart';
import '../repositories/home_repository.dart';
import '../../data/models/servise_setting_model.dart';
import '../../../../core/providers/error/failures.dart';
import '../../../../core/providers/service_locator.dart';
import 'package:reminder/core/providers/usecase/usecase.dart';

class CheckSettingSRVUseCase implements UseCase<ServiceSettingModel, Parms> {
  @override
  Future<Either<Failure, ServiceSettingModel>> call([Parms? params]) async {
    return await sl<HomeRepository>().checkStatusService();
  }
}
