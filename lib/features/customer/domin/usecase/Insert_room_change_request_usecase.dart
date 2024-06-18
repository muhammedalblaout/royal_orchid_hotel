
import 'package:fpdart/fpdart.dart';
import 'package:royal_orchid_hotel/features/customer/domin/repository/customer_repository.dart';
import '../../../../core/entites/room_change_request.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class InsertRoomChangeRequestUsecase implements Usecase<void,InsertRoomChangeRequestParams>{
  CustomerRepository Repository;

  InsertRoomChangeRequestUsecase(this.Repository);

  @override
  Future<Either<Failures, void>> call(InsertRoomChangeRequestParams params)async {
    return await Repository.insertRoomChangeRequest(params.request);
  }

}
class InsertRoomChangeRequestParams{
  RoomChangeRequest request;

  InsertRoomChangeRequestParams(this.request);
}