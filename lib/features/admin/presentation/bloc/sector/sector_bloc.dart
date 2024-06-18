import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../domin/usecase/get_sector_usecase.dart';

part 'sector_event.dart';

part 'sector_state.dart';

class SectorBloc extends Bloc<SectorEvent, SectorState> {
  final GetSectorUsecase _getSectorUsecase;

  SectorBloc({required GetSectorUsecase getSectorUsecase})
      : _getSectorUsecase = getSectorUsecase,
        super(SectorInitial()) {
    on<SectorEvent>((event, emit) {});
    on<GetAllSectorEvent>((event, emit) async {
      emit(SectorLoading());
      final res = await _getSectorUsecase(NoParams());
      res.fold(
          (l) => emit(SectorFaill(l.massage)), (r) => emit(SectorSuccess(r)));
    });
  }
}
