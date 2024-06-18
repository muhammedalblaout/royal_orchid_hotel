
import 'package:fpdart/fpdart.dart';

import '../../../../core/entites/user.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/admin_repository.dart';

class InsertUserUsecase implements Usecase<void,InserUserParams>{
  AdminRepository Repository;

  InsertUserUsecase(this.Repository);

  @override
  Future<Either<Failures, void>> call(InserUserParams params)async {
    return await Repository.insertUser(params.user);
  }

}
class InserUserParams{
  User user;

  InserUserParams(this.user);
}