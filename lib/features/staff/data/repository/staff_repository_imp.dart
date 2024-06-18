import 'package:fpdart/src/either.dart';
import 'package:royal_orchid_hotel/core/entites/request.dart';
import 'package:royal_orchid_hotel/core/error/failures.dart';
import 'package:royal_orchid_hotel/core/model/staff_status_model.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../core/model/request_model.dart';
import '../../domin/repository/staff_repository.dart';
import '../datasource/staff_datasource.dart';

class StaffRepositoryImp implements StaffRepository {
  StaffDatasource staffDatasource;

  StaffRepositoryImp(this.staffDatasource);

  @override
  Future<Either<Failures, List<Request>>> getSectorRequest(
      String sector) async {
    try {
      final res = await staffDatasource.getSectorRequest(sector);
      return right(res);
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, void>> updateRequets(Request request) async {
    try {
      RequestModel requestModel = RequestModel(
          id: request.id,
          customer_id: request.customer_id,
          Staff_id: request.Staff_id,
          Service_id: request.Service_id,
          room_id: request.room_id,
          accepted_at: DateTime.now(),
          isAccepted: request.isAccepted,
          sector: request.sector);
      final res = await staffDatasource.updateRequest(requestModel);
      return right(res);
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, List<Request>>> getStaffRequest(String id) async {
    try {
      final res = await staffDatasource.getStaffRequest(id);

      return right(res);

    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, void>> updateDelivereRequets(Request request) async {
    try {
      RequestModel requestModel = RequestModel(
          id: request.id,
          customer_id: request.customer_id,
          Staff_id: request.Staff_id,
          Service_id: request.Service_id,
          room_id: request.room_id,
          accepted_at: DateTime.now(),
          isAccepted: request.isAccepted,
          isDelivered: request.isDelivered,
          sector: request.sector);
      final res = await staffDatasource.updateDelivereRequest(requestModel);
      return right(res);
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }

  @override
  Future<Either<Failures, StaffStatusModel>> getStaffStatus(String id) async {
    try {
      var res = await staffDatasource.getStaffStatus(id);
      var list=await staffDatasource.getStaffMonthlyActivity(id);
      res=res.copyWith(monthlyStatus: list);
      return right(res);
    } on ServerExcepiton catch (e) {
      return left(Failures(e.massage));
    }
  }
}
