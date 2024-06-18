import 'package:royal_orchid_hotel/core/model/request_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../core/model/staff_status_model.dart';

abstract interface class StaffDatasource {
  Future<List<RequestModel>> getSectorRequest(String sector);

  Future<List<RequestModel>> getStaffRequest(String id);

  Future<void> updateRequest(RequestModel requestModel);

  Future<void> updateDelivereRequest(RequestModel requestModel);

  Future<StaffStatusModel> getStaffStatus(String id);

  Future<List<MonthlyStatusModel>> getStaffMonthlyActivity(String id);
}

class StaffDatasourceImp implements StaffDatasource {
  final SupabaseClient supabaseClient;

  StaffDatasourceImp(this.supabaseClient);

  @override
  Future<List<RequestModel>> getSectorRequest(String sector) async {
    try {
      final infoData = await supabaseClient
          .rpc("get_sector_requests", params: {'my_sector': sector});
      var list = List<RequestModel>.from(infoData.map((x) {
        return RequestModel.fromJson(x);
      }));
      return list;
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.message);
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<void> updateRequest(RequestModel requestModel) async {
    try {
      await supabaseClient
          .from('requests')
          .update(requestModel.UpdateJson())
          .match({'id': requestModel.id});
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.message);
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<List<RequestModel>> getStaffRequest(String id) async {
    try {
      final infoData =
          await supabaseClient.rpc("get_staff_requests", params: {'myid': id});
      var list = List<RequestModel>.from(infoData.map((x) {
        return RequestModel.fromJson(x);
      }));
      return list;
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.message);
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<void> updateDelivereRequest(RequestModel requestModel) async {
    try {
      await supabaseClient
          .from('requests')
          .update(requestModel.DeliveredJson())
          .match({'id': requestModel.id});
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.message);
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<StaffStatusModel> getStaffStatus(String id) async {
    try {
      final infoData =
          await supabaseClient.rpc("get_staff_status", params: {'myid': id});

      return StaffStatusModel.fromJson(infoData[0]);
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.message);
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<List<MonthlyStatusModel>> getStaffMonthlyActivity(String id) async {
    try {
      final infoData = await supabaseClient
          .rpc("get_staff_monthly_activity", params: {'myid': id});
      var list = List<MonthlyStatusModel>.from(infoData.map((x) {
        return MonthlyStatusModel.fromJson(x);
      }));
      return list;
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.message);
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }
}
