import 'package:fpdart/src/either.dart';
import 'package:royal_orchid_hotel/core/entites/invoice.dart';
import 'package:royal_orchid_hotel/core/error/failures.dart';

import '../../../../core/usecase/usecase.dart';
import '../repository/admin_repository.dart';

class GetCustomerInvoiceUsecase implements Usecase<List<Invoice>,CustomerInvoiceParamas>{
  final AdminRepository repository;

  GetCustomerInvoiceUsecase(this.repository);

  @override
  Future<Either<Failures, List<Invoice>>> call(CustomerInvoiceParamas params)async {
    return await repository.getCustomerInvoice(params.user_id);
  }

}
class CustomerInvoiceParamas{
  final String user_id;

  CustomerInvoiceParamas(this.user_id);
}