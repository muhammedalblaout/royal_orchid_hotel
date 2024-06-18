part of 'staff_request_bloc.dart';

@immutable
sealed class StaffRequestEvent {}
class GetSectorRequestsEvent extends  StaffRequestEvent {
  final String sector;

  GetSectorRequestsEvent(this.sector);

}
class GetStaffRequestsEvent extends  StaffRequestEvent {
  final String id;

  GetStaffRequestsEvent(this.id);

}

class GetStaffStatusEvent extends  StaffRequestEvent {
  final String id;

  GetStaffStatusEvent(this.id);

}

class UpdateRequestsEvent extends  StaffRequestEvent {
  final Request request;

  UpdateRequestsEvent(this.request);

}

class UpdateDeilvereRequestsEvent extends  StaffRequestEvent {
  final Request request;

  UpdateDeilvereRequestsEvent(this.request);

}
