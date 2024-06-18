import 'package:fpdart/fpdart.dart';
import 'package:royal_orchid_hotel/core/entites/service.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/admin_repository.dart';

class InsertServiceUsecase implements Usecase<void,ServiceParams>{
  AdminRepository Repository;

  InsertServiceUsecase(this.Repository);

  @override
  Future<Either<Failures, void>> call(ServiceParams params)async {
    return await Repository.insertService(params.service);
  }

}
class UpdateServiceUsecase implements Usecase<void,ServiceParams>{
  AdminRepository Repository;

  UpdateServiceUsecase(this.Repository);

  @override
  Future<Either<Failures, void>> call(ServiceParams params)async {
    return await Repository.updateService(params.service);
  }

}

class ServiceParams{
  final Service service;

  ServiceParams(this.service);
}