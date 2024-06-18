import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:royal_orchid_hotel/core/entites/service.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../domin/usecase/admin_service_usecaes.dart';
import '../../../domin/usecase/get_admin_services_usecase.dart';

part 'service_event.dart';

part 'service_state.dart';

class AdminServiceBloc extends Bloc<AdminServiceEvent, AdminServiceState> {
  final GetAdminServicesUsecase _getAdminServicesUsecase;
  final InsertServiceUsecase _insertServiceUsecase;
  final UpdateServiceUsecase _updateServiceUsecase;

  AdminServiceBloc(
      {required GetAdminServicesUsecase getAdminServicesUsecase,
      required InsertServiceUsecase insertServiceUsecase,
      required UpdateServiceUsecase updateServiceUsecase})
      : _getAdminServicesUsecase = getAdminServicesUsecase,
        _insertServiceUsecase = insertServiceUsecase,
        _updateServiceUsecase = updateServiceUsecase,
        super(AdminServiceInitial()) {
    on<AdminServiceEvent>((event, emit) {});

    on<GetAdminServiceEvent>((event, emit) async {
      emit(AdminServiceLoading());
      final res = await _getAdminServicesUsecase(NoParams());
      res.fold((l) => emit(AdminServiceFail(l.massage)),
          (r) => emit(AdminServiceSuccess(r)));
    });

    on<AdminInsertServiceEvent>((event, emit) async {
      emit(AdminServiceLoading());
      final res = await _insertServiceUsecase(ServiceParams(event.service));
      res.fold((l) => emit(AdminServiceFail(l.massage)),
          (r) => emit(AdminUpdateServiceSuccess()));
    });
    on<AdminUpdateServiceEvent>((event, emit) async {
      emit(AdminServiceLoading());
      final res = await _updateServiceUsecase(ServiceParams(event.service));
      res.fold((l) => emit(AdminServiceFail(l.massage)),
              (r) => emit(AdminUpdateServiceSuccess()));
    });
  }
}
