import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../entites/user.dart';
import 'app_user_state.dart';


class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(User? user ){
    if(user==null){
      emit(AppUserInitial());
    }
    else{
      if(user.role==1){
        emit(AppAdminLoggin(user));

      }
      else if (user.role==2){
        emit(AppStaffLoggin(user));

      }
      else{
        emit(AppCustomerLoggin(user));

      }
    }
  }

  Future<void> logout( ) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('user');
    emit(AppUserLogout());

  }

}
