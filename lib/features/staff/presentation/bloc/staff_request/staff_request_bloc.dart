import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:royal_orchid_hotel/core/entites/staff_status.dart';

import '../../../../../../core/entites/request.dart';
import '../../../domin/usecase/get_sector_request_usecase.dart';
import '../../../domin/usecase/get_staff_request_usecase.dart';
import '../../../domin/usecase/get_staff_status_usecase.dart';
import '../../../domin/usecase/update_deilvere_request_usecase.dart';
import '../../../domin/usecase/update_request_usecase.dart';

part 'staff_request_event.dart';

part 'staff_request_state.dart';

class StaffRequestBloc extends Bloc<StaffRequestEvent, StaffRequestState> {
  final GetSectorRequestsUsecase _getSectorRequestsUsecase;
  final GetStaffRequestsUsecase _getStaffRequestsUsecase;
  final GetStaffStatusUsecase _getStaffStatusUsecase;


  final UpdateRequestUsecase _updateRequestUsecase;
  final UpdateDeilvereRequestUsecase _deilvereRequestUsecase;


  StaffRequestBloc({required GetSectorRequestsUsecase getSectorRequestsUsecase,
    required GetStaffRequestsUsecase getStaffRequestsUsecase,
    required GetStaffStatusUsecase getStaffStatusUsecase,
    required UpdateRequestUsecase updateRequestUsecase,
    required UpdateDeilvereRequestUsecase deilvereRequestUsecase
  })
      : _getSectorRequestsUsecase = getSectorRequestsUsecase,
        _getStaffRequestsUsecase=getStaffRequestsUsecase,
        _getStaffStatusUsecase=getStaffStatusUsecase,
        _updateRequestUsecase=updateRequestUsecase,
         _deilvereRequestUsecase= deilvereRequestUsecase,
        super(StaffRequestInitial()) {
    on<StaffRequestEvent>((event, emit) {});
    on<GetSectorRequestsEvent>((event, emit) async {
      emit(StaffRequestLoading());
      final res =
      await _getSectorRequestsUsecase(SectorRequestParamas(event.sector));
      res.fold((l) => emit(StaffRequestFail(l.massage)),
              (r) => emit(StaffRequestSuccess(r)));
    });
    on<GetStaffRequestsEvent>((event, emit) async {
      emit(StaffRequestLoading());
      final res =
      await _getStaffRequestsUsecase(StaffRequestParamas(event.id));
      res.fold((l) => emit(StaffRequestFail(l.massage)),
              (r) => emit(StaffRequestSuccess(r)));
    });
    on<UpdateRequestsEvent>((event, emit) async {
      emit(StaffRequestLoading());
      final res =
      await _updateRequestUsecase(UpdateRequestParams(event.request));
      res.fold((l) => emit(StaffRequestFail(l.massage)),
              (r) => emit(StaffUpdateRequestSuccess()));
    });

    on<UpdateDeilvereRequestsEvent>((event, emit) async {
      emit(StaffRequestLoading());
      final res =
      await _deilvereRequestUsecase(UpdatedeilverRequestParams(event.request));
      res.fold((l) => emit(StaffRequestFail(l.massage)),
              (r) => emit(StaffUpdateRequestSuccess()));
    });

    on<GetStaffStatusEvent>((event, emit) async {
      emit(StaffRequestLoading());
      final res =
      await _getStaffStatusUsecase(StaffStatusParamas(event.id));
      res.fold((l) => emit(StaffRequestFail(l.massage)),
              (r) => emit(StaffStatusSuccess(r)));
    });

  }
}
