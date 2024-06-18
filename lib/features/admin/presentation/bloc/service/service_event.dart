part of 'service_bloc.dart';

@immutable
sealed class AdminServiceEvent {}
class GetAdminServiceEvent extends AdminServiceEvent{

}
class AdminInsertServiceEvent extends AdminServiceEvent{
final Service service;

AdminInsertServiceEvent(this.service);
}

class AdminUpdateServiceEvent extends AdminServiceEvent{
  final Service service;

  AdminUpdateServiceEvent(this.service);
}
