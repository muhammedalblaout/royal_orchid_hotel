class User{
  final String id;
  final String name;
  final String email;
  final String sector;
  final String room;
  final String? password;
  final int role;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.sector,
    required this.room,
    required this.role,
    this.password

  });




}