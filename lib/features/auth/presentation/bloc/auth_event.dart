part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {

}
class SignInEvent extends AuthEvent{
  final String email;
  final String password;

  SignInEvent(this.email, this.password);
}

class AuthIsUserLoggedInEvent extends AuthEvent{

}