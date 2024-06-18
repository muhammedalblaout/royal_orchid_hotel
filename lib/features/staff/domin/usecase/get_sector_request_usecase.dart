import 'package:fpdart/src/either.dart';
import 'package:royal_orchid_hotel/core/entites/request.dart';
import 'package:royal_orchid_hotel/core/error/failures.dart';

import '../../../../../core/usecase/usecase.dart';
import '../repository/staff_repository.dart';


class GetSectorRequestsUsecase implements Usecase<List<Request>,SectorRequestParamas>{
  final StaffRepository staffRepository;

  GetSectorRequestsUsecase(this.staffRepository);

  @override
  Future<Either<Failures, List<Request>>> call(SectorRequestParamas params)async {
    return await staffRepository.getSectorRequest(params.sector);
  }

}
class SectorRequestParamas{
  String sector;

  SectorRequestParamas(this.sector);
}