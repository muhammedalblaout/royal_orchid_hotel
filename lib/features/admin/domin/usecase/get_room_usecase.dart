import 'package:fpdart/src/either.dart';
import 'package:royal_orchid_hotel/core/error/failures.dart';
import 'package:royal_orchid_hotel/core/usecase/usecase.dart';
import 'package:royal_orchid_hotel/features/admin/domin/repository/admin_repository.dart';

import '../../../../core/entites/room.dart';

class GetRoomsUsecase implements Usecase<List<Room>,NoParams>{
  AdminRepository roomRepository;

  GetRoomsUsecase(this.roomRepository);

  @override
  Future<Either<Failures, List<Room>>> call(NoParams params)async {
    return await roomRepository.getRooms();
  }

}