import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:royal_orchid_hotel/core/commen/cubit/app_user/app_user_cubit.dart';

import '../../../../core/entites/user.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domin/usecases/current_user_usecase.dart';
import '../../domin/usecases/signin_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUsecase _signInUsecase;
  final AppUserCubit _appUserCubit;
  final CurrentUserUsecase _currentUserUsecase;



  AuthBloc({required SignInUsecase signInUsecase,
  required AppUserCubit appUserCubit,
  required CurrentUserUsecase currentUserUsecase} )
      : _signInUsecase = signInUsecase,
        _appUserCubit =appUserCubit,
        _currentUserUsecase =currentUserUsecase,

  super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      final res=await _signInUsecase(SignInParams(Email: event.email, Password: event.password));
      res.fold((l) => emit(AuthFaill(l.massage)), (r) => _emitAuthSuccess(r,emit));
    });

    on<AuthIsUserLoggedInEvent>((event, emit) async {
      emit(AuthLoading());

      final res= await _currentUserUsecase(NoParams());

      res.fold((l) => emit(AuthFaill(l.massage)),
              (r) {
            print(r.email);
            _emitAuthSuccess(r,emit);
          }
      );
    });
  }


  void _emitAuthSuccess(User user,Emitter<AuthState> emit){
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }


}
