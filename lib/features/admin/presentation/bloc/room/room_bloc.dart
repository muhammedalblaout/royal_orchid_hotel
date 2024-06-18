import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:royal_orchid_hotel/core/entites/room_change_request.dart';
import 'package:royal_orchid_hotel/features/admin/domin/usecase/get_room_usecase.dart';
import 'package:royal_orchid_hotel/features/admin/domin/usecase/update_room_change_request_usecaes.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../../../core/entites/room.dart';
import '../../../domin/usecase/get_all_room_change_request_usecase.dart';

part 'room_event.dart';

part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final GetRoomsUsecase _getRoomsUsecase;
  final GetAllRoomChangeRequestUsecase _getAllRoomChangeRequestUsecase;
  final UpdateRoomChangeRequestUsecase _updateRoomChnageRequestUsecase;

  RoomBloc(
      {required GetRoomsUsecase getRoomsUsecase,
      required GetAllRoomChangeRequestUsecase getAllRoomChangeRequestUsecase,
      required UpdateRoomChangeRequestUsecase updateRoomChangeRequestUsecase})
      : _getRoomsUsecase = getRoomsUsecase,
        _getAllRoomChangeRequestUsecase = getAllRoomChangeRequestUsecase,
        _updateRoomChnageRequestUsecase = updateRoomChangeRequestUsecase,
        super(RoomInitial()) {
    on<RoomEvent>((event, emit) {});
    on<GetAllRoomsEvent>((event, emit) async {
      emit(RoomLoading());
      final res = await _getRoomsUsecase(NoParams());
      res.fold((l) => emit(RoomFaill(l.massage)), (r) => emit(RoomSuccess(r)));
    });

    on<GetAllRoomChangeRequestsEvent>((event, emit) async {
      emit(RoomLoading());
      final res = await _getAllRoomChangeRequestUsecase(NoParams());
      res.fold((l) => emit(RoomFaill(l.massage)),
          (r) => emit(DisplayRoomChangeRequewstSuccess(r)));
    });

    on<UpdateRoomChangeRequestEvent>((event, emit) async {
      emit(RoomLoading());
      final res = await _updateRoomChnageRequestUsecase(
          UpdateChangeRoomRequestParams(event.roomChangeRequest));
      res.fold((l) => emit(RoomFaill(l.massage)),
          (r) => emit(UpdateRoomChangeSuccess()));
    });
  }
}
