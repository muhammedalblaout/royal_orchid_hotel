import 'package:fpdart/src/either.dart';
import 'package:royal_orchid_hotel/core/error/failures.dart';
import 'package:royal_orchid_hotel/core/usecase/usecase.dart';
import 'package:royal_orchid_hotel/features/admin/domin/repository/admin_repository.dart';


class GetSectorUsecase implements Usecase<List<String>,NoParams>{
  AdminRepository roomRepository;

  GetSectorUsecase(this.roomRepository);

  @override
  Future<Either<Failures, List<String>>> call(NoParams params)async {
    return await roomRepository.getSectors();
  }

}