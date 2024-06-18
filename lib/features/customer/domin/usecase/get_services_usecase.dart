import 'package:fpdart/src/either.dart';
import 'package:royal_orchid_hotel/core/error/failures.dart';
import 'package:royal_orchid_hotel/core/entites/service.dart';
import 'package:royal_orchid_hotel/features/customer/domin/repository/customer_repository.dart';

import '../../../../core/usecase/usecase.dart';

class GetAllServicesUsecase implements Usecase<List<Service>,NoParams>{
  final CustomerRepository customerRepository;

  GetAllServicesUsecase(this.customerRepository);

  @override
  Future<Either<Failures, List<Service>>> call(NoParams params)async {
    return await customerRepository.getAllServices();
  }

}