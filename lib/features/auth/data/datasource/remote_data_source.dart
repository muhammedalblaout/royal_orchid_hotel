import 'package:royal_orchid_hotel/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';
import '../../../../core/model/user_model.dart';

abstract interface class RemoteDataSource {
  Future<UserModel> signIn(String email, String password);

  Future<UserModel> getStaffData(UserModel userModel);

  Future<UserModel> getCustomerData(UserModel userModel);

  Future<Map<String, dynamic>?> getCurrentUserData();
}

class RemoteDataSourceImp implements RemoteDataSource {
  final SupabaseClient supabaseClient;
  final SharedPreferences prefs;

  RemoteDataSourceImp(this.supabaseClient, this.prefs);

  @override
  Future<UserModel> signIn(String email, String password) async {
    try {
      final res = await supabaseClient
          .from("auth")
          .select()
          .eq("email", email)
          .eq("password", password)
          .select();

      if (res.isEmpty) {
        throw const ServerExcepiton(massage: "Wrong Email or Password");
      }
      await prefs.setString(
          'user', jsonEncode({'email': email, 'password': password}));

      return UserModel.fromJson(res.first);
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.toString());
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>?> getCurrentUserData() async {
    try {
      var currentUserSession = prefs.getString('user');

      if (currentUserSession != null) {
        Map<String, dynamic> json = jsonDecode(currentUserSession);

        return json;
      }
      return null;
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.message);
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.massage);
    }
  }

  @override
  Future<UserModel> getStaffData(UserModel userModel) async {
    try {
      final res = await supabaseClient
          .from("staff")
          .select()
          .eq("id", userModel.id)
          .select();
      var user = UserModel.fromJson(res.first)
          .copyWith(email: userModel.email, role: userModel.role);

      return user;
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.toString());
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }

  @override
  Future<UserModel> getCustomerData(UserModel userModel) async {
    try {
      final res = await supabaseClient
          .from("customer")
          .select()
          .eq("id", userModel.id)
          .select('*,rooms(sector,room_id)');

      var user = UserModel.fromJson(res.first)
          .copyWith(email: userModel.email, role: userModel.role);

      return user;
    } on PostgrestException catch (e) {
      throw ServerExcepiton(massage: e.toString());
    } on ServerExcepiton catch (e) {
      throw ServerExcepiton(massage: e.toString());
    }
  }
}
