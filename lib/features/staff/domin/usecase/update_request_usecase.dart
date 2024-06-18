
import 'package:fpdart/fpdart.dart';
import 'package:royal_orchid_hotel/core/entites/request.dart';
import 'package:royal_orchid_hotel/features/staff/domin/repository/staff_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class UpdateRequestUsecase implements Usecase<void,UpdateRequestParams>{
  final StaffRepository Repository;

  UpdateRequestUsecase(this.Repository);

  @override
  Future<Either<Failures, void>> call(UpdateRequestParams params)async {
    return await Repository.updateRequets(params.request);
  }

}
class UpdateRequestParams{
  Request request;

  UpdateRequestParams(this.request);
}