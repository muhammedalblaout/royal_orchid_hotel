import 'package:fpdart/fpdart.dart';
import 'package:royal_orchid_hotel/core/entites/user.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/admin_repository.dart';

class GetAllStaffUsecase implements Usecase<List<User>,NoParams>{
  AdminRepository Repository;

  GetAllStaffUsecase(this.Repository);

  @override
  Future<Either<Failures, List<User>>> call(NoParams params)async {
    return await Repository.getAllStaff();
  }

}