import '../entites/room_change_request.dart';

class RoomChangeRequestModel extends RoomChangeRequest {
  RoomChangeRequestModel(
      { super.id,
      required super.to_room_id,
      required super.customer_id,
      super.created_at,
      super.is_accepted,
      super.customer_name,
      super.from_room_id});
  Map<String, dynamic> UploadRequestJson() {
    return {
      'to_room_id': to_room_id,
      'customer_id': customer_id,
    };
  }
  Map<String, dynamic> UpdateJson() {
    return {
      'is_accepted': is_accepted,
    };
  }

  factory RoomChangeRequestModel.fromJson(Map<String, dynamic> map) {
    return RoomChangeRequestModel(
      id: map['id'] as String,
      created_at:DateTime.parse(map['created_at']),
      to_room_id: map['to_room_id'] as String,
      customer_id: map['customer_id'] as String,
      is_accepted: map['is_accepted'] ,
      customer_name: map['name'] ,
      from_room_id: map['room_id'] ,

    );
  }
}
