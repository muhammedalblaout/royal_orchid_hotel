import 'package:royal_orchid_hotel/core/model/room_change_request_model.dart';
import 'package:royal_orchid_hotel/core/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/model/invoice_model.dart';
import '../../../../core/model/room_model.dart';
import '../../../../core/model/service_model.dart';
import '../../../../core/model/staff_status_model.dart';

abstract interface class AdminRemoteDataSource {
  Future<List<RoomModel>> getRoom();

  Future<List<String>> getSector();

  Future<void> insertUser(UserModel userModel);

  Future<List<UserModel>> getCustomers();

  Future<List<UserModel>> getStaff();

  Future<List<RoomChangeRequestModel>> getChangeRoomRequest();

  Future<void> updateRoomChangeRequest(
      RoomChangeRequestModel roomChangeRequestModel);

  Future<List<ServiceModel>> getServices();

  Future<void> insertServices(ServiceModel serviceModel);

  Future<void> updateServices(ServiceModel serviceModel);

  Future<List<InvoiceModel>> getCustomerInvoice(String userId);

  Future<StaffStatusModel> getStaffStatus(String id);

  Future<List<MonthlyStatusModel>> getStaffMonthlyActivity(String id);
}

class AdminRemoteDataSourceimp implements AdminRemoteDataSource {
  final SupabaseClient supabaseClient;

  AdminRemoteDataSourceimp(this.supabaseClient);

  @override
  Future<List<RoomModel>> getRoom() async {
    try {
      final infoData = await supabaseClient
          .from("rooms")
          .select()
          .eq('availability', true)
          .select();

      var info = List<RoomModel>.from(infoData.map((x) {
        return RoomModel.fromJson(x);
      }));

      return info;
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.message);
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<List<String>> getSector() async {
    try {
      final infoData = await supabaseClient.rpc("get_sectors");
      var results = List<String>.from(infoData.map((x) {
        return x["distinct_values"] as String;
      }));
      return results;
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.message);
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<void> insertUser(UserModel userModel) async {
    try {
      await supabaseClient.from("auth").insert(userModel.toJsosUpload());
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.message);
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<List<UserModel>> getCustomers() async {
    try {
      final infoData = await supabaseClient.rpc("get_customers");
      var list = List<UserModel>.from(infoData.map((x) {
        return UserModel.fromJson(x);
      }));
      return list;
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.message);
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<List<UserModel>> getStaff() async {
    try {
      final infoData = await supabaseClient.rpc("get_staff");
      var list = List<UserModel>.from(infoData.map((x) {
        return UserModel.fromJson(x);
      }));
      return list;
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.message);
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<List<RoomChangeRequestModel>> getChangeRoomRequest() async {
    try {
      final infoData =
          await supabaseClient.rpc("get_change_room_request_requests");
      var list = List<RoomChangeRequestModel>.from(infoData.map((x) {
        return RoomChangeRequestModel.fromJson(x);
      }));
      return list;
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.message);
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<void> updateRoomChangeRequest(
      RoomChangeRequestModel roomChangeRequestModel) async {
    try {
      await supabaseClient
          .from("room_change")
          .update(roomChangeRequestModel.UpdateJson())
          .match({'id': roomChangeRequestModel.id});
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.message);
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<List<ServiceModel>> getServices() async {
    try {
      final infoData = await supabaseClient.from("hotel_services").select();

      var list = List<ServiceModel>.from(infoData.map((x) {
        return ServiceModel.fromJson(x);
      }));
      return list;
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.message);
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<void> insertServices(ServiceModel serviceModel) async {
    try {
      await supabaseClient.from("hotel_services").insert(serviceModel.toJson());
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.message);
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<void> updateServices(ServiceModel serviceModel) async {
    try {
      await supabaseClient
          .from("hotel_services")
          .update(serviceModel.toJson())
          .match({'id': serviceModel.id});
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.message);
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<List<InvoiceModel>> getCustomerInvoice(String userId) async {
    try {
      final infoData = await supabaseClient
          .rpc("get_customer_invoices", params: {'myid': userId});
      var list = List<InvoiceModel>.from(infoData.map((x) {
        return InvoiceModel.fromJson(x);
      }));
      return list;
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
