import 'package:royal_orchid_hotel/core/entites/service.dart';

class ServiceModel extends Service {
  ServiceModel({required super.name, required super.price,super.available,super.id});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'available': available,
    };
  }

  factory ServiceModel.fromJson(Map<String, dynamic> map) {
    return ServiceModel(
      id:map['id'],
      name: map['name'] as String,
      price: map['price'] as int,
      available: map['available'] ,
    );
  }
}

