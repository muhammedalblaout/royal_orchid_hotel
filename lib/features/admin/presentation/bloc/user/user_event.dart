part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}
class InsertUserEvent extends UserEvent{
  final User user;

  InsertUserEvent(this.user);
}
class GetAllCustomerEvent extends UserEvent{

  GetAllCustomerEvent();
}

class GetAllStaffEvent extends UserEvent{

  GetAllStaffEvent();
}
class GetCustomerInvoiceEvent extends UserEvent{
  final String userId;
  GetCustomerInvoiceEvent(this.userId);

}
class GetStatusEvent extends UserEvent{
final String userId;
GetStatusEvent(this.userId);

}