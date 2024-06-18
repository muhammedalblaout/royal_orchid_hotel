
import 'package:fpdart/fpdart.dart';
import 'package:royal_orchid_hotel/core/entites/staff_status.dart';

import '../../../../../core/entites/request.dart';
import '../../../../../core/error/failures.dart';

abstract interface class StaffRepository{

  Future<Either<Failures,List<Request>>> getSectorRequest(String sector);
  Future<Either<Failures,List<Request>>> getStaffRequest(String id);

  Future<Either<Failures,StaffStatus>> getStaffStatus(String id);


  Future<Either<Failures,void>> updateRequets(Request request);
  Future<Either<Failures,void>> updateDelivereRequets(Request request);




}