import 'package:fpdart/src/either.dart';
import 'package:royal_orchid_hotel/core/entites/room_change_request.dart';
import 'package:royal_orchid_hotel/core/error/failures.dart';
import 'package:royal_orchid_hotel/features/customer/domin/repository/customer_repository.dart';

import '../../../../core/usecase/usecase.dart';

class GetMyChangeRoomRequestsUsecase implements Usecase<RoomChangeRequest?,MyChangeRoomRequestParamas>{
  final CustomerRepository customerRepository;

  GetMyChangeRoomRequestsUsecase(this.customerRepository);

  @override
  Future<Either<Failures, RoomChangeRequest?>> call(MyChangeRoomRequestParamas params)async {
    return await customerRepository.getRoomChangeRequest(params.user_id);
  }

}
class MyChangeRoomRequestParamas{
  String user_id;

  MyChangeRoomRequestParamas(this.user_id);
}