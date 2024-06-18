import 'package:fpdart/src/either.dart';
import 'package:royal_orchid_hotel/core/error/failures.dart';
import 'package:royal_orchid_hotel/core/entites/service.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/admin_repository.dart';

class GetAdminServicesUsecase implements Usecase<List<Service>,NoParams>{
  final AdminRepository Repository;

  GetAdminServicesUsecase(this.Repository);

  @override
  Future<Either<Failures, List<Service>>> call(NoParams params)async {
    return await Repository.getAllServices();
  }

}