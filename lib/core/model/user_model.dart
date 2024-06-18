import 'package:royal_orchid_hotel/core/entites/user.dart';

class UserModel extends User {
  UserModel(
      {required super.name,
      required super.email,
      required super.sector,
      required super.room,
      required super.role,
      required super.id,
        super.password
      }
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'sector': sector,
      'room_id': room,
      'role_id': role,
      'id':id
    };
  }

  Map<String, dynamic> toJsosUpload() {
    RawData rawData=RawData(Name: name, Room: room, Sector: sector);
    return {
      'email': email,
      'password':password,
      'role_id': role,
      'raw_data':rawData.tojson()
    };
  }


  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?? " ",
      name: map['name'] ?? " ",
      email: map['email'] ??" ",
      sector: map['sector'] ?? (map['rooms']!=null?map['rooms'][0]['sector']:" "),
      room: map['room_id']==null?map['rooms']!=null?map['rooms'][0]['room_id']:" ": map["room_id"] ,
      role: map['role_id'] ?? 0,
    );
  }
  UserModel copyWith({
    String? id,
    String? name,
    String? password,
    String? email,
    String? sector,
    String? room,
    int? role,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      sector: sector ?? this.sector,
      room: room ?? this.room,
      role: role ?? this.role,
    );
  }
}
class RawData{
  String Name;
  String Room;
  String Sector;

  RawData({
    required this.Name,
    required this.Room,
    required this.Sector,
  });

  Map<String, dynamic> tojson() {
    return {
      'name': Name,
      'room_id': Room==" "?null:Room,
      'sector': Sector==" "?null:Sector,
    };
  }

}
