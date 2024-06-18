import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:royal_orchid_hotel/core/entites/invoice.dart';
import 'package:royal_orchid_hotel/core/usecase/usecase.dart';
import 'package:royal_orchid_hotel/features/admin/domin/usecase/Insert_user_usecaes.dart';
import 'package:royal_orchid_hotel/features/admin/domin/usecase/get_status_usecase.dart';

import '../../../../../core/entites/staff_status.dart';
import '../../../../../core/entites/user.dart';
import '../../../domin/usecase/get_all_customers_usecase.dart';
import '../../../domin/usecase/get_all_staff_usecase.dart';
import '../../../domin/usecase/get_customer_invoice_usecase.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final InsertUserUsecase _insertUserUsecase;
  final GetAllCustomersUsecase _getAllCustomersUsecase;
  final GetAllStaffUsecase _getAllStaffUsecase;
  final GetCustomerInvoiceUsecase _getCustomerInvoiceUsecase;
  final GetStatusUsecase _getStatusUsecase;

  UserBloc(
      {required InsertUserUsecase insertUserUsecase,
      required GetAllCustomersUsecase getAllCustomersUsecase,
      required GetAllStaffUsecase getAllStaffUsecase,
      required GetCustomerInvoiceUsecase getCustomerInvoiceUsecase,
      required GetStatusUsecase getStatusUsecase})
      : _insertUserUsecase = insertUserUsecase,
        _getAllCustomersUsecase = getAllCustomersUsecase,
        _getAllStaffUsecase = getAllStaffUsecase,
        _getCustomerInvoiceUsecase = getCustomerInvoiceUsecase,
        _getStatusUsecase = getStatusUsecase,
        super(UserInitial()) {
    on<UserEvent>((event, emit) {});

    on<InsertUserEvent>((event, emit) async {
      emit(UserLoading());
      final res = await _insertUserUsecase(InserUserParams(event.user));
      res.fold((l) => emit(UserFail(l.massage)), (r) => emit(UserSuccess()));
    });

    on<GetAllCustomerEvent>((event, emit) async {
      emit(UserLoading());
      final res = await _getAllCustomersUsecase(NoParams());
      res.fold((l) => emit(UserFail(l.massage)),
          (r) => emit(DisplayUsersSuccess(r)));
    });
    on<GetAllStaffEvent>((event, emit) async {
      emit(UserLoading());
      final res = await _getAllStaffUsecase(NoParams());
      res.fold((l) => emit(UserFail(l.massage)),
          (r) => emit(DisplayUsersSuccess(r)));
    });
    on<GetCustomerInvoiceEvent>((event, emit) async {
      emit(UserLoading());
      final res = await _getCustomerInvoiceUsecase(
          CustomerInvoiceParamas(event.userId));
      res.fold((l) => emit(UserFail(l.massage)),
          (r) => emit(DisplayCustomerInvoicesSuccess(r)));
    });

    on<GetStatusEvent>((event, emit) async {
      emit(UserLoading());
      final res = await _getStatusUsecase(StatusParamas(event.userId));
      res.fold((l) => emit(UserFail(l.massage)),
          (r) => emit(DisplayStatusSuccess(r)));
    });
  }
}
