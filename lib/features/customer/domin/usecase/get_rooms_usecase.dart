import 'package:fpdart/src/either.dart';
import 'package:royal_orchid_hotel/core/entites/room.dart';
import 'package:royal_orchid_hotel/core/error/failures.dart';
import 'package:royal_orchid_hotel/features/customer/domin/repository/customer_repository.dart';

import '../../../../core/usecase/usecase.dart';

class GetCustomerRoomsUsecase implements Usecase<List<Room>,NoParams>{
  final CustomerRepository customerRepository;

  GetCustomerRoomsUsecase(this.customerRepository);

  @override
  Future<Either<Failures, List<Room>>> call(NoParams params)async {
    return await customerRepository.getRooms();
  }

}
