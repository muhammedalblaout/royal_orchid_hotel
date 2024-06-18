import 'package:royal_orchid_hotel/core/entites/invoice.dart';

class InvoiceModel extends Invoice {
  InvoiceModel(
      {required super.id,
      required super.request_id,
      required super.staff_id,
      required super.customer_id,
      required super.staff_name,
      required super.customer_name,
      required super.service_name,
      required super.price,
      required super.created_at});

  factory InvoiceModel.fromJson(Map<String, dynamic> map) {
    return InvoiceModel(
      id: map['id'] as String,
      request_id: map['request_id'] as String,
      staff_id: map['staff_id'] as String,
      customer_id: map['customer_id'] as String,
      staff_name: map['staff_name'] as String,
      customer_name: map['customer_name'] as String,
      service_name: map['service_name'] as String,
      price: map['price'] as int,
      created_at:DateTime.parse(map['created_at']),
    );
  }
}
