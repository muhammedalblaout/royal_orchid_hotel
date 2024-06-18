part of 'staff_request_bloc.dart';

@immutable
sealed class StaffRequestState {}

final class StaffRequestInitial extends StaffRequestState {}
final class StaffRequestFail extends StaffRequestState {
  final String massage;

  StaffRequestFail(this.massage);
}

final class StaffUpdateRequestSuccess extends StaffRequestState {

  StaffUpdateRequestSuccess();
}
final class StaffStatusSuccess extends StaffRequestState {
  final StaffStatus staffStatus;
  StaffStatusSuccess(this.staffStatus);
}

final class StaffRequestSuccess extends StaffRequestState {
  final List<Request> list;

  StaffRequestSuccess(this.list);
}
final class StaffRequestLoading extends StaffRequestState {

}
