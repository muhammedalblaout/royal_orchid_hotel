class Service{
  final int? id;

  final String name;
  final int price;
  final bool? available;

  Service({
    this.id,
    required this.name,
    required this.price,
    this.available,
  });


}