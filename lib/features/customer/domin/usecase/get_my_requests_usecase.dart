import 'package:fpdart/src/either.dart';
import 'package:royal_orchid_hotel/core/entites/request.dart';
import 'package:royal_orchid_hotel/core/error/failures.dart';
import 'package:royal_orchid_hotel/features/customer/domin/repository/customer_repository.dart';

import '../../../../core/usecase/usecase.dart';

class GetMyRequestsUsecase implements Usecase<List<Request>,MyRequestParamas>{
  final CustomerRepository customerRepository;

  GetMyRequestsUsecase(this.customerRepository);

  @override
  Future<Either<Failures, List<Request>>> call(MyRequestParamas params)async {
    return await customerRepository.getMyRequests(params.user_id);
  }

}
class MyRequestParamas{
  String user_id;

  MyRequestParamas(this.user_id);
}