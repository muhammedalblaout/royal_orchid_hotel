import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:royal_orchid_hotel/core/entites/invoice.dart';
import 'package:royal_orchid_hotel/core/entites/request.dart';
import 'package:royal_orchid_hotel/core/entites/room.dart';
import 'package:royal_orchid_hotel/core/entites/room_change_request.dart';
import 'package:royal_orchid_hotel/core/usecase/usecase.dart';

import '../../../domin/usecase/Insert_request_usecase.dart';
import '../../../domin/usecase/Insert_room_change_request_usecase.dart';
import '../../../domin/usecase/get_my_change_room_requests_usecase.dart';
import '../../../domin/usecase/get_my_invoice_usecase.dart';
import '../../../domin/usecase/get_my_requests_usecase.dart';
import '../../../domin/usecase/get_rooms_usecase.dart';

part 'request_event.dart';

part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final InsertRequestUsecase _inserRequestUsecase;
  final InsertRoomChangeRequestUsecase _insertRoomChangeRequestUsecase;
  final GetMyRequestsUsecase _getMyRequestsUsecase;
  final GetMyChangeRoomRequestsUsecase _getMyChangeRoomRequestsUsecase;

  final GetMyInvoiceUsecase _getMyInvoiceUsecase;
  final GetCustomerRoomsUsecase _getRoomsUsecase;

  RequestBloc({required InsertRequestUsecase insertRequestUsecase,
    required InsertRoomChangeRequestUsecase insertRoomChangeRequestUsecase,
    required GetMyRequestsUsecase getMyRequestsUsecase,
    required GetMyChangeRoomRequestsUsecase getMyChangeRoomRequestsUsecase,

    required GetMyInvoiceUsecase getMyInvoiceUsecase,
    required GetCustomerRoomsUsecase getRoomsUsecase
  })
      : _inserRequestUsecase = insertRequestUsecase,
        _insertRoomChangeRequestUsecase=insertRoomChangeRequestUsecase,
        _getMyRequestsUsecase = getMyRequestsUsecase,
        _getMyChangeRoomRequestsUsecase = getMyChangeRoomRequestsUsecase,

      _getMyInvoiceUsecase = getMyInvoiceUsecase,
        _getRoomsUsecase = getRoomsUsecase,


        super(RequestInitial()) {
    on<RequestEvent>((event, emit) {});
    on<InsertRequestEvent>((event, emit) async {
      emit(RequestLoading());
      final res =
      await _inserRequestUsecase(InsertRequestParams(event.request));
      res.fold((l) => emit(RequestFail(l.massage)),
              (r) => emit(InsertRequestSuccess()));
    });

    on<GetMyRequestEvent>((event, emit) async {
      emit(RequestLoading());
      final res =
      await _getMyRequestsUsecase(MyRequestParamas(event.user_id));
      res.fold((l) => emit(RequestFail(l.massage)),
              (r) => emit(DisplayMyRequestSuccess(r)));
    });

    on<GetMyInvoiceEvent>((event, emit) async {
      emit(RequestLoading());
      final res =
      await _getMyInvoiceUsecase(MyInvoiceParamas(event.user_id));
      res.fold((l) => emit(RequestFail(l.massage)),
              (r) => emit(DisplayInvoiceSuccess(r)));
    });

    on<GetRoomsEvent>((event, emit) async {
      emit(RequestLoading());
      final res =
      await _getRoomsUsecase(NoParams());
      res.fold((l) => emit(RequestFail(l.massage)),
              (r) => emit(DisplayRoomsSuccess(r)));
    });

    on<InsertRoomChangeRequestEvent>((event, emit) async {
      if(event.request.to_room_id=='--'){
        emit(RequestFail("Choose A Room First"));
      }
      else{
        final res =
        await _insertRoomChangeRequestUsecase(InsertRoomChangeRequestParams(event.request));
        res.fold((l) => emit(RequestFail(l.massage)),
                (r) => emit(InsertRequestSuccess()));
      }

    });

    on<GetMyChangeRoomRequestEvent>((event, emit) async {
      emit(RequestLoading());
      final res =
      await _getMyChangeRoomRequestsUsecase(MyChangeRoomRequestParamas(event.user_id));
      res.fold((l) => emit(RequestFail(l.massage)),
              (r) => emit(DisplayChangeRoomsSuccess(r)));
    });

  }
}
