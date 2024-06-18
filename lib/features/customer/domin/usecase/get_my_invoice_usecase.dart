import 'package:fpdart/src/either.dart';
import 'package:royal_orchid_hotel/core/entites/invoice.dart';
import 'package:royal_orchid_hotel/core/error/failures.dart';
import 'package:royal_orchid_hotel/features/customer/domin/repository/customer_repository.dart';

import '../../../../core/usecase/usecase.dart';

class GetMyInvoiceUsecase implements Usecase<List<Invoice>,MyInvoiceParamas>{
  final CustomerRepository customerRepository;

  GetMyInvoiceUsecase(this.customerRepository);

  @override
  Future<Either<Failures, List<Invoice>>> call(MyInvoiceParamas params)async {
    return await customerRepository.getInvoice(params.user_id);
  }

}
class MyInvoiceParamas{
  String user_id;

  MyInvoiceParamas(this.user_id);
}