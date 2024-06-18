import 'package:fpdart/src/either.dart';
import 'package:royal_orchid_hotel/core/entites/staff_status.dart';
import 'package:royal_orchid_hotel/core/error/failures.dart';
import 'package:royal_orchid_hotel/features/admin/domin/repository/admin_repository.dart';
import '../../../../../core/usecase/usecase.dart';

class GetStatusUsecase implements Usecase<StaffStatus, StatusParamas> {
  final AdminRepository repository;

  GetStatusUsecase(this.repository);

  @override
  Future<Either<Failures, StaffStatus>> call(StatusParamas params) async {
    return await repository.getStaffStatus(params.id);
  }
}

class StatusParamas {
  String id;

  StatusParamas(this.id);
}
