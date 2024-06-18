
class RoomChangeRequest{
   String? id;
  DateTime? created_at;
  final String to_room_id;
  final String customer_id;
  bool? is_accepted;
   String? customer_name;
   String? from_room_id;


   RoomChangeRequest({
     this.id,
    this.created_at,
    required this.to_room_id,
    required this.customer_id,
    this.is_accepted,
     this.customer_name,
     this.from_room_id
  });

   RoomChangeRequest copyWith({
    String? id,
    DateTime? created_at,
    String? to_room_id,
    String? customer_id,
    bool? is_accepted,
    String? customer_name,
    String? from_room_id,
  }) {
    return RoomChangeRequest(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      to_room_id: to_room_id ?? this.to_room_id,
      customer_id: customer_id ?? this.customer_id,
      is_accepted: is_accepted ?? this.is_accepted,
      customer_name: customer_name ?? this.customer_name,
      from_room_id: from_room_id ?? this.from_room_id,
    );
  }
}