import 'package:fpdart/src/either.dart';
import 'package:royal_orchid_hotel/core/entites/staff_status.dart';
import 'package:royal_orchid_hotel/core/error/failures.dart';

import '../../../../../core/usecase/usecase.dart';
import '../repository/staff_repository.dart';


class GetStaffStatusUsecase implements Usecase<StaffStatus,StaffStatusParamas>{
  final StaffRepository staffRepository;

  GetStaffStatusUsecase(this.staffRepository);

  @override
  Future<Either<Failures, StaffStatus>> call(StaffStatusParamas params)async {
    return await staffRepository.getStaffStatus(params.id);
  }

}
class StaffStatusParamas{
  String id;

  StaffStatusParamas(this.id);
}