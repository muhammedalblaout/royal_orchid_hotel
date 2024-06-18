
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:royal_orchid_hotel/core/entites/service.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../domin/usecase/get_services_usecase.dart';

part 'service_event.dart';

part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final GetAllServicesUsecase _getAllServicesUsecase;

  ServiceBloc({required GetAllServicesUsecase getAllServicesUsecase})
      : _getAllServicesUsecase = getAllServicesUsecase,
        super(ServiceInitial()) {
    on<ServiceEvent>((event, emit) {});

    on<GetAllServicesEvent>((event, emit)async {
      emit(ServiceLoading());
      final res = await _getAllServicesUsecase(NoParams());
      res.fold(
          (l) => emit(ServiceFail(l.massage)), (r) => emit(ServiceSuccess(r)));
    });
  }
}
