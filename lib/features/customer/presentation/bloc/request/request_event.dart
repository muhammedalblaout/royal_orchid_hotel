part of 'request_bloc.dart';

@immutable
sealed class RequestEvent {}

class InsertRequestEvent extends RequestEvent{
  final Request request;

  InsertRequestEvent({
    required this.request,
  });
}

class InsertRoomChangeRequestEvent extends RequestEvent{
  final RoomChangeRequest request;

  InsertRoomChangeRequestEvent({
    required this.request,
  });
}

class GetMyRequestEvent extends RequestEvent{
  final String user_id;

  GetMyRequestEvent({
    required this.user_id,
  });
}

class GetMyInvoiceEvent extends RequestEvent {
  final String user_id;

  GetMyInvoiceEvent({
    required this.user_id,
  });
}
  class GetRoomsEvent extends RequestEvent{

  GetRoomsEvent();


}
class GetMyChangeRoomRequestEvent extends RequestEvent{
  final String user_id;

  GetMyChangeRoomRequestEvent({
    required this.user_id,
  });
}

