
import 'package:royal_orchid_hotel/core/entites/request.dart';

class RequestModel extends Request {
  RequestModel({
    required super.customer_id,
    super.customer_name,
    required super.Service_id,
    super.service_name,
    super.price,
    super.id,
    super.Staff_id,
    super.staff_name,
    super.isAccepted,
    super.created_at,
    super.accepted_at,
    required super.room_id,
    required super.sector,
    super.isDelivered

  });

  Map<String, dynamic> InsertJson() {
    return {
      'customer_id': customer_id,
      'service_id': Service_id,
      'room_id': room_id,
      'sector': sector,
    };
  }
  Map<String, dynamic> UpdateJson() {
    return {
      'accepted_at': accepted_at!.toIso8601String(),
      'is_accepted': isAccepted,
      'staff_id': Staff_id,
    };
  }

  Map<String, dynamic> DeliveredJson() {
    return {
      'is_accepted': isDelivered,
      'is_delivered': isDelivered,

    };
  }

  factory RequestModel.fromJson(Map<String, dynamic> map) {
    return RequestModel(
      id: map['id'],
      created_at: DateTime.parse(map['created_at']),
      accepted_at:map['accepted_at']==null?null: DateTime.parse(map['accepted_at']),
      customer_id: map['customer_id'] as String,
      customer_name: map['customer_name'],
      Staff_id: map['Staff_id'],
      staff_name: map['staff_name'],
      Service_id: map['service_id'] as int,
      isAccepted: map['is_accepted'],
      isDelivered: map['is_delivered'],
      room_id: map['room_id'],
      sector: map['sector'],
      service_name: map['service_name'],
      price: map['price'],
    );
  }
  @override
  RequestModel copyWith({
    String? id,
    DateTime? created_at,
    DateTime? accepted_at,
    String? room_id,
    String? sector,
    String? customer_id,
    String? customer_name,
    String? Staff_id,
    String? staff_name,
    int? Service_id,
    String? service_name,
    int? price,
    bool? isAccepted,
    bool ?isDelivered
  }) {
    return RequestModel(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      accepted_at: accepted_at ?? this.accepted_at,
      room_id: room_id ?? this.room_id,
      sector: sector ?? this.sector,
      customer_id: customer_id ?? this.customer_id,
      customer_name: customer_name ?? this.customer_name,
      Staff_id: Staff_id ?? this.Staff_id,
      staff_name: staff_name ?? this.staff_name,
      Service_id: Service_id ?? this.Service_id,
      service_name: service_name ?? this.service_name,
      price: price ?? this.price,
      isAccepted: isAccepted ?? this.isAccepted,
      isDelivered: isDelivered?? this.isDelivered
    );
  }
}
