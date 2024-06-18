part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserSuccess extends UserState {}

final class UserFail extends UserState {
  final String massage;

  UserFail(this.massage);
}

final class UserLoading extends UserState {}

final class DisplayUsersSuccess extends UserState {
  final List<User> users;

  DisplayUsersSuccess(this.users);
}

final class DisplayCustomerInvoicesSuccess extends UserState {
  final List<Invoice> list;

  DisplayCustomerInvoicesSuccess(this.list);
}

final class DisplayStatusSuccess extends UserState {
  final StaffStatus status;

  DisplayStatusSuccess(this.status);
}
