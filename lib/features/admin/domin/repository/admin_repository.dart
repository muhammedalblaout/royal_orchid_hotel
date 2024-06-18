import 'package:fpdart/fpdart.dart';
import 'package:royal_orchid_hotel/core/entites/service.dart';
import 'package:royal_orchid_hotel/core/error/failures.dart';

import '../../../../core/entites/invoice.dart';
import '../../../../core/entites/room_change_request.dart';
import '../../../../core/entites/staff_status.dart';
import '../../../../core/entites/user.dart';
import '../../../../core/entites/room.dart';

abstract interface class AdminRepository {
  Future<Either<Failures, List<Room>>> getRooms();

  Future<Either<Failures, List<String>>> getSectors();

  Future<Either<Failures, void>> insertUser(User user);

  Future<Either<Failures, List<User>>> getAllCustomer();

  Future<Either<Failures, List<User>>> getAllStaff();

  Future<Either<Failures, List<RoomChangeRequest>>> getChangeRoomRequest();

  Future<Either<Failures, void>> updateRoomChangeRequest(
      RoomChangeRequest roomChangeRequest);

  Future<Either<Failures, List<Service>>> getAllServices();

  Future<Either<Failures, void>> insertService(Service service);

  Future<Either<Failures, void>> updateService(Service service);

  Future<Either<Failures, List<Invoice>>> getCustomerInvoice(String userId);

  Future<Either<Failures, StaffStatus>> getStaffStatus(String id);
}
