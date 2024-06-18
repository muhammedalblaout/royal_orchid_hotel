import 'package:fpdart/src/either.dart';
import 'package:royal_orchid_hotel/core/entites/invoice.dart';
import 'package:royal_orchid_hotel/core/entites/room_change_request.dart';
import 'package:royal_orchid_hotel/core/entites/service.dart';
import 'package:royal_orchid_hotel/core/entites/user.dart';
import 'package:royal_orchid_hotel/core/error/exceptions.dart';

import 'package:royal_orchid_hotel/core/error/failures.dart';
import 'package:royal_orchid_hotel/core/model/room_change_request_model.dart';
import 'package:royal_orchid_hotel/core/model/service_model.dart';
import 'package:royal_orchid_hotel/core/model/user_model.dart';

import '../../../../core/entites/room.dart';
import '../../../../core/model/staff_status_model.dart';
import '../../domin/repository/admin_repository.dart';
import '../datasource/admin_remote_data_source.dart';

class AdminRepositoryImp implements AdminRepository {
  AdminRemoteDataSource remoteDataSource;

  AdminRepositoryImp(this.remoteDataSource);

  @override
  Future<Either<Failures, List<Room>>> getRooms() async {
    try {
      final res = await remoteDataSource.getRoom();
      await remoteDataSource.getCustomers();
      return right(res);
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, List<String>>> getSectors() async {
    try {
      final res = await remoteDataSource.getSector();
      return right(res);
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, void>> insertUser(User user) async {
    try {
      UserModel userModel = UserModel(
          name: user.name,
          email: user.email,
          sector: user.sector,
          room: user.room,
          role: user.role,
          id: user.id,
          password: user.password);
    await remoteDataSource.insertUser(userModel);
      return right(());
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, List<User>>> getAllCustomer() async {
    try {
      final res = await remoteDataSource.getCustomers();
      return right(res);
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, List<User>>> getAllStaff() async {
    try {
      final res = await remoteDataSource.getStaff();
      return right(res);
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, List<RoomChangeRequestModel>>>
      getChangeRoomRequest() async {
    try {
      final res = await remoteDataSource.getChangeRoomRequest();
      return right(res);
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, void>> updateRoomChangeRequest(
      RoomChangeRequest roomChangeRequest) async {
    try {
      RoomChangeRequestModel roomChangeRequestModel = RoomChangeRequestModel(
          id: roomChangeRequest.id,
          to_room_id: roomChangeRequest.to_room_id,
          customer_id: roomChangeRequest.customer_id,
          from_room_id: roomChangeRequest.from_room_id,
          customer_name: roomChangeRequest.customer_name,
          created_at: roomChangeRequest.created_at,
          is_accepted: roomChangeRequest.is_accepted);
      await remoteDataSource.updateRoomChangeRequest(roomChangeRequestModel);
      return right(());
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, List<Service>>> getAllServices() async {
    try {
      final res = await remoteDataSource.getServices();
      return right(res);
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, void>> insertService(Service service) async {
    try {
      ServiceModel serviceModel = ServiceModel(
          name: service.name,
          price: service.price,
          available: service.available);
      await remoteDataSource.insertServices(serviceModel);
      return right(());
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, void>> updateService(Service service) async {
    try {
      ServiceModel serviceModel = ServiceModel(
        id: service.id,
          name: service.name,
          price: service.price,
          available: service.available);
      await remoteDataSource.updateServices(serviceModel);
      return right(());
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, List<Invoice>>> getCustomerInvoice(String userId) async {
    try {
      final res = await remoteDataSource.getCustomerInvoice(userId);

      return right(res);
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }
  @override
  Future<Either<Failures, StaffStatusModel>> getStaffStatus(String id) async {
    try {
      var res = await remoteDataSource.getStaffStatus(id);
      var list=await remoteDataSource.getStaffMonthlyActivity(id);
      res=res.copyWith(monthlyStatus: list);
      return right(res);
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }
}
