class Invoice{
  final String id;
  final String request_id;
  final String staff_id;
  final String customer_id;
  final String staff_name;
  final String customer_name;
  final String service_name;
  final int price;
  final DateTime created_at;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'request_id': request_id,
      'staff_id': staff_id,
      'customer_id': customer_id,
      'staff_name': staff_name,
      'customer_name': customer_name,
      'service_name': service_name,
      'price': price,
      'created_at': created_at,
    };
  }

  factory Invoice.fromMap(Map<String, dynamic> map) {
    return Invoice(
      id: map['id'] as String,
      request_id: map['request_id'] as String,
      staff_id: map['staff_id'] as String,
      customer_id: map['customer_id'] as String,
      staff_name: map['staff_name'] as String,
      customer_name: map['customer_name'] as String,
      service_name: map['service_name'] as String,
      price: map['price'] as int,
      created_at: map['created_at'] as DateTime,
    );
  }

  const Invoice({
    required this.id,
    required this.request_id,
    required this.staff_id,
    required this.customer_id,
    required this.staff_name,
    required this.customer_name,
    required this.service_name,
    required this.price,
    required this.created_at,
  });
}