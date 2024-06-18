import '../entites/room.dart';

class RoomModel extends Room {
  RoomModel(
      {required super.room_id,
      required super.availability,
      required super.Sector});
  Map<String, dynamic> toJson() {
    return {
      'room_id': room_id,
      'availability': availability,
      'Sector': Sector,
    };
  }

  factory RoomModel.fromJson(Map<String, dynamic> map) {
    return RoomModel(
      room_id: map['room_id'] as String,
      availability: map['availability'] as bool,
      Sector: map['sector'] as String,
    );
  }
}
