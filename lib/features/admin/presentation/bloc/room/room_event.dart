part of 'room_bloc.dart';

@immutable
sealed class RoomEvent {}
class GetAllRoomsEvent extends RoomEvent{}
class GetAllRoomChangeRequestsEvent extends RoomEvent{}

class UpdateRoomChangeRequestEvent extends RoomEvent{
  final RoomChangeRequest roomChangeRequest;

  UpdateRoomChangeRequestEvent(this.roomChangeRequest);
}


