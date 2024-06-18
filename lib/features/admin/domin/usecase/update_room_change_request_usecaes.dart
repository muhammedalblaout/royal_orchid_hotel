
import 'package:fpdart/fpdart.dart';
import 'package:royal_orchid_hotel/core/entites/room_change_request.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/admin_repository.dart';

class UpdateRoomChangeRequestUsecase implements Usecase<void,UpdateChangeRoomRequestParams>{
  final AdminRepository repository;

  UpdateRoomChangeRequestUsecase(this.repository);

  @override
  Future<Either<Failures, void>> call(UpdateChangeRoomRequestParams params)async {
    return await repository.updateRoomChangeRequest(params.roomChangeRequest);
  }

}
class UpdateChangeRoomRequestParams{
  RoomChangeRequest roomChangeRequest;

  UpdateChangeRoomRequestParams(this.roomChangeRequest);
}