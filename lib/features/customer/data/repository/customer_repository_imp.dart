import 'package:fpdart/src/either.dart';
import 'package:royal_orchid_hotel/core/entites/invoice.dart';
import 'package:royal_orchid_hotel/core/entites/request.dart';

import 'package:royal_orchid_hotel/core/error/failures.dart';
import 'package:royal_orchid_hotel/core/model/request_model.dart';
import 'package:royal_orchid_hotel/core/model/room_change_request_model.dart';
import 'package:royal_orchid_hotel/features/customer/data/data_source/customer_data_source.dart';

import 'package:royal_orchid_hotel/core/entites/service.dart';

import '../../../../core/entites/room.dart';
import '../../../../core/entites/room_change_request.dart';
import '../../../../core/error/exceptions.dart';
import '../../domin/repository/customer_repository.dart';

class CustomerRepositoryImp implements CustomerRepository {
  CustomerDataSource customerDataSource;

  CustomerRepositoryImp(this.customerDataSource);

  @override
  Future<Either<Failures, List<Room>>> getRooms() async {
    try {
      final res = await customerDataSource.getRoom();
      return right(res);
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, List<Service>>> getAllServices() async {
    try {
      final res = await customerDataSource.getServices();
      return right(res);
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, void>> insertRequest(Request request) async {
    try {
      RequestModel requestModel = RequestModel(
          customer_id: request.customer_id,
          Service_id: request.Service_id,
          room_id: request.room_id,
          sector: request.sector);

      await customerDataSource.inserRequest(requestModel);
      return right(());
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, List<Request>>> getMyRequests(String userId) async {
    try {
      final res = await customerDataSource.getMyRequests(userId);
     await customerDataSource.getRoomChangeRequest( userId);

      return right(res);
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, List<Invoice>>> getInvoice(String userId) async {
    try {
      final res = await customerDataSource.getMyInvoice(userId);

      return right(res);
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, void>> insertRoomChangeRequest(
      RoomChangeRequest request) async {
    try {
      RoomChangeRequestModel requestModel = RoomChangeRequestModel(
          to_room_id: request.to_room_id,
          customer_id: request.customer_id);

      await customerDataSource.inserRoomChangeRequest(requestModel);
      return right(());
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, RoomChangeRequestModel?>> getRoomChangeRequest(String userId) async {
    try {
      final res = await customerDataSource.getRoomChangeRequest( userId);

      return right(res);
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }
}
