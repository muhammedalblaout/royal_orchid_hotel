import 'package:flutter/cupertino.dart';

import '../../../entites/user.dart';


@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}
final class AppUserLoggin extends AppUserState {
  final User user;

  AppUserLoggin(this.user);
}

final class AppAdminLoggin extends AppUserState {
  final User user;

  AppAdminLoggin(this.user);
}
final class AppCustomerLoggin extends AppUserState {
  final User user;

  AppCustomerLoggin(this.user);
}
final class AppStaffLoggin extends AppUserState {
  final User user;

  AppStaffLoggin(this.user);
}



final class AppUserLogout extends AppUserState {

  AppUserLogout();
}


