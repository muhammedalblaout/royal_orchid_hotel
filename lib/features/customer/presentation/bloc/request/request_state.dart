part of 'request_bloc.dart';

@immutable
sealed class RequestState {}

final class RequestInitial extends RequestState {}
final class InsertRequestSuccess extends RequestState {}

final class RequestFail extends RequestState {
  final String massage;

  RequestFail(this.massage);
}
final class RequestLoading extends RequestState {}

final class DisplayMyRequestSuccess extends RequestState {
  final List<Request> list ;
  DisplayMyRequestSuccess(this.list);
}

final class DisplayInvoiceSuccess extends RequestState {
  final List<Invoice> list ;
  DisplayInvoiceSuccess(this.list);
}

final class DisplayRoomsSuccess extends RequestState {
  final List<Room> list ;
  DisplayRoomsSuccess(this.list);
}
final class DisplayChangeRoomsSuccess extends RequestState {
  final RoomChangeRequest? request ;
  DisplayChangeRoomsSuccess(this.request);
}

