import 'package:royal_orchid_hotel/core/entites/room.dart';
import 'package:royal_orchid_hotel/core/model/invoice_model.dart';
import 'package:royal_orchid_hotel/core/model/request_model.dart';
import 'package:royal_orchid_hotel/core/model/room_change_request_model.dart';
import 'package:royal_orchid_hotel/core/model/service_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/model/room_model.dart';

abstract interface class CustomerDataSource {
  Future<List<ServiceModel>> getServices();

  Future<void> inserRequest(RequestModel requestModel);

  Future<void> inserRoomChangeRequest(
      RoomChangeRequestModel roomChangeRequestModel);

  Future<List<RequestModel>> getMyRequests(String userId);

  Future<List<InvoiceModel>> getMyInvoice(String userId);

  Future<List<Room>> getRoom();

  Future<RoomChangeRequestModel?> getRoomChangeRequest(String userId);
}

class CustomerDataSourceImp implements CustomerDataSource {
  final SupabaseClient supabaseClient;

  CustomerDataSourceImp(this.supabaseClient);

  @override
  Future<List<ServiceModel>> getServices() async {
    try {
      final infoData = await supabaseClient.rpc("get_available_services");
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
  Future<void> inserRequest(RequestModel requestModel) async {
    try {
      await supabaseClient.from('requests').insert(requestModel.InsertJson());
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.message);
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<List<RequestModel>> getMyRequests(String userId) async {
    try {
      final infoData = await supabaseClient
          .rpc("get_customer_requests", params: {'myid': userId});
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
  Future<List<InvoiceModel>> getMyInvoice(String userId) async {
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
  Future<List<Room>> getRoom() async {
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
  Future<void> inserRoomChangeRequest(
      RoomChangeRequestModel roomChangeRequestModel) async {
    try {
      await supabaseClient
          .from('room_change')
          .insert(roomChangeRequestModel.UploadRequestJson());
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.message);
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<RoomChangeRequestModel?> getRoomChangeRequest(String userId) async {
    try {
      final res = await supabaseClient
          .from('room_change')
          .select()
          .eq('customer_id', userId)
          .order('created_at', ascending: false)
          .select();
      if (res.isEmpty) {
        return null;
      } else {
        return RoomChangeRequestModel.fromJson(res[0]);
      }
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.message);
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }
}
