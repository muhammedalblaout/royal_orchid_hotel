
import 'package:fpdart/fpdart.dart';
import 'package:royal_orchid_hotel/core/entites/request.dart';
import 'package:royal_orchid_hotel/features/customer/domin/repository/customer_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class InsertRequestUsecase implements Usecase<void,InsertRequestParams>{
  CustomerRepository Repository;

  InsertRequestUsecase(this.Repository);

  @override
  Future<Either<Failures, void>> call(InsertRequestParams params)async {
    return await Repository.insertRequest(params.request);
  }

}
class InsertRequestParams{
  Request request;

  InsertRequestParams(this.request);
}