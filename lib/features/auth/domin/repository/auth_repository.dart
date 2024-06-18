import 'package:fpdart/fpdart.dart';
import 'package:royal_orchid_hotel/core/entites/user.dart';
import 'package:royal_orchid_hotel/core/error/failures.dart';

abstract interface class AuthRepository{
  Future<Either<Failures,User>>signIn(String email,String password);
  Future<Either<Failures,User>> currentUser();

}