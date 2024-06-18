import 'package:fpdart/fpdart.dart';
import 'package:royal_orchid_hotel/core/error/failures.dart';
import 'package:royal_orchid_hotel/core/entites/service.dart';

import '../../../../core/entites/invoice.dart';
import '../../../../core/entites/request.dart';
import '../../../../core/entites/room.dart';
import '../../../../core/entites/room_change_request.dart';

abstract interface class CustomerRepository{
  Future<Either<Failures,List<Service>>> getAllServices();
  Future<Either<Failures,void>> insertRequest(Request request);
  Future<Either<Failures,void>> insertRoomChangeRequest(RoomChangeRequest request);

  Future<Either<Failures,List<Request>>> getMyRequests(String userId);
  Future<Either<Failures,List<Invoice>>> getInvoice(String userId);
  Future<Either<Failures,List<Room>>> getRooms();
  Future<Either<Failures,RoomChangeRequest?>> getRoomChangeRequest(String userId);





}