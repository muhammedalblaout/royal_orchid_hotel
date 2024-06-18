import 'package:fpdart/src/either.dart';
import 'package:royal_orchid_hotel/core/error/failures.dart';
import 'package:royal_orchid_hotel/core/usecase/usecase.dart';
import 'package:royal_orchid_hotel/features/auth/domin/repository/auth_repository.dart';

import '../../../../core/entites/user.dart';

class SignInUsecase implements Usecase<User,SignInParams>{
  AuthRepository authRepository;

  SignInUsecase(this.authRepository);

  @override
  Future<Either<Failures, User>> call(SignInParams params) async {
    return await authRepository.signIn(params.Email, params.Password);
  }

}

class SignInParams{
  final String Email;
  final String Password;

  const SignInParams({
    required this.Email,
    required this.Password,
  });

}