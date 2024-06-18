
import 'package:fpdart/fpdart.dart';
import 'package:royal_orchid_hotel/core/entites/request.dart';
import 'package:royal_orchid_hotel/features/staff/domin/repository/staff_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class UpdateDeilvereRequestUsecase implements Usecase<void,UpdatedeilverRequestParams>{
  final StaffRepository Repository;

  UpdateDeilvereRequestUsecase(this.Repository);

  @override
  Future<Either<Failures, void>> call(UpdatedeilverRequestParams params)async {
    return await Repository.updateDelivereRequets(params.request);
  }

}
class UpdatedeilverRequestParams{
  Request request;

  UpdatedeilverRequestParams(this.request);
}