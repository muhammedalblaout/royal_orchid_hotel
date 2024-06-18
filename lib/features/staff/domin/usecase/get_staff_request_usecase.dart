import 'package:fpdart/src/either.dart';
import 'package:royal_orchid_hotel/core/entites/request.dart';
import 'package:royal_orchid_hotel/core/error/failures.dart';

import '../../../../../core/usecase/usecase.dart';
import '../repository/staff_repository.dart';


class GetStaffRequestsUsecase implements Usecase<List<Request>,StaffRequestParamas>{
  final StaffRepository staffRepository;

  GetStaffRequestsUsecase(this.staffRepository);

  @override
  Future<Either<Failures, List<Request>>> call(StaffRequestParamas params)async {
    return await staffRepository.getStaffRequest(params.id);
  }

}
class StaffRequestParamas{
  String id;

  StaffRequestParamas(this.id);
}