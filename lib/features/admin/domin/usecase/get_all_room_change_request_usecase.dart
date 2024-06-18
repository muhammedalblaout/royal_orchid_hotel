import 'package:fpdart/fpdart.dart';

import '../../../../core/entites/room_change_request.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/admin_repository.dart';

class GetAllRoomChangeRequestUsecase implements Usecase<List<RoomChangeRequest>,NoParams>{
  AdminRepository Repository;

  GetAllRoomChangeRequestUsecase(this.Repository);

  @override
  Future<Either<Failures, List<RoomChangeRequest>>> call(NoParams params)async {
    return await Repository.getChangeRoomRequest();
  }

}