import 'package:fpdart/src/either.dart';
import 'package:royal_orchid_hotel/core/entites/user.dart';
import 'package:royal_orchid_hotel/core/error/exceptions.dart';
import 'package:royal_orchid_hotel/core/error/failures.dart';
import 'package:royal_orchid_hotel/features/auth/domin/repository/auth_repository.dart';

import '../datasource/remote_data_source.dart';

class AuthRepositoryImp implements AuthRepository {
  RemoteDataSource remoteDataSource;

  AuthRepositoryImp(this.remoteDataSource);

  @override
  Future<Either<Failures, User>> signIn(String email, String password) async {
    try {
      final temp = await remoteDataSource.signIn(email, password);
      if (temp.role == 3) {
        final user = await remoteDataSource.getCustomerData(temp);
        return right(user);
      } else {
        final user = await remoteDataSource.getStaffData(temp);
        return right(user);
      }
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, User>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failures("User is not logged in!"));
      }


      return signIn(user['email'],user['password']);
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }
}
