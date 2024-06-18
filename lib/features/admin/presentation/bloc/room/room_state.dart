part of 'room_bloc.dart';

@immutable
sealed class RoomState {}

final class RoomInitial extends RoomState {}
final class RoomFaill extends RoomState{
 final String massage;

  RoomFaill(this.massage);
}
final class RoomSuccess extends RoomState {
  final List<Room> rooms;

  RoomSuccess(this.rooms);
}
final class RoomLoading extends RoomState {}

final class DisplayRoomChangeRequewstSuccess extends RoomState {
  final List<RoomChangeRequest> list;

  DisplayRoomChangeRequewstSuccess(this.list);
}
final class UpdateRoomChangeSuccess extends RoomState {}


