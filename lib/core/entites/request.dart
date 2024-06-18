class Request{
  String? id;
  DateTime? created_at;
  DateTime? accepted_at;
  String room_id;
  String sector;
  String customer_id;
  String? customer_name;
  String? Staff_id;
  String? staff_name;
  int Service_id;
  String? service_name;
  int? price;
  bool? isAccepted;
  bool? isDelivered;

  Request({
    this.id,
    this.created_at,
    this.accepted_at,
    required this.customer_id,
    this.customer_name,
    required this.room_id,
    required this.sector,
    this.Staff_id,
    this.staff_name,
    required this.Service_id,
    this.service_name,
    this.price,
    this.isAccepted,
    this.isDelivered
  });
  String IsAnswered(){
    if(isAccepted==null){
      return "In Queue";
    }
    return "Answered";
  }

  Request copyWith({
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
    bool? isDelivered,


  }) {
    return Request(
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
      isDelivered: isDelivered ?? this.isDelivered,

    );
  }
}