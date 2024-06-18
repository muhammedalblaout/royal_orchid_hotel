import 'package:get_it/get_it.dart';
import 'package:royal_orchid_hotel/features/admin/data/datasource/admin_remote_data_source.dart';
import 'package:royal_orchid_hotel/features/admin/domin/usecase/admin_service_usecaes.dart';
import 'package:royal_orchid_hotel/features/admin/domin/usecase/Insert_user_usecaes.dart';
import 'package:royal_orchid_hotel/features/admin/domin/usecase/get_admin_services_usecase.dart';
import 'package:royal_orchid_hotel/features/admin/domin/usecase/get_all_customers_usecase.dart';
import 'package:royal_orchid_hotel/features/admin/domin/usecase/get_all_room_change_request_usecase.dart';
import 'package:royal_orchid_hotel/features/admin/domin/usecase/get_customer_invoice_usecase.dart';
import 'package:royal_orchid_hotel/features/admin/domin/usecase/get_status_usecase.dart';
import 'package:royal_orchid_hotel/features/admin/domin/usecase/update_room_change_request_usecaes.dart';
import 'package:royal_orchid_hotel/features/admin/presentation/bloc/sector/sector_bloc.dart';
import 'package:royal_orchid_hotel/features/admin/presentation/bloc/service/service_bloc.dart';
import 'package:royal_orchid_hotel/features/admin/presentation/bloc/user/user_bloc.dart';
import 'package:royal_orchid_hotel/features/auth/domin/usecases/signin_usecase.dart';
import 'package:royal_orchid_hotel/features/customer/data/data_source/customer_data_source.dart';
import 'package:royal_orchid_hotel/features/customer/data/repository/customer_repository_imp.dart';
import 'package:royal_orchid_hotel/features/customer/domin/usecase/Insert_room_change_request_usecase.dart';
import 'package:royal_orchid_hotel/features/customer/domin/usecase/get_my_requests_usecase.dart';
import 'package:royal_orchid_hotel/features/customer/domin/usecase/get_services_usecase.dart';
import 'package:royal_orchid_hotel/features/customer/presentation/bloc/request/request_bloc.dart';
import 'package:royal_orchid_hotel/features/staff/data/datasource/staff_datasource.dart';
import 'package:royal_orchid_hotel/features/staff/data/repository/staff_repository_imp.dart';
import 'package:royal_orchid_hotel/features/staff/domin/usecase/get_sector_request_usecase.dart';
import 'package:royal_orchid_hotel/features/staff/domin/usecase/get_staff_status_usecase.dart';
import 'package:royal_orchid_hotel/features/staff/domin/usecase/update_deilvere_request_usecase.dart';
import 'package:royal_orchid_hotel/features/staff/domin/usecase/update_request_usecase.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/commen/cubit/app_user/app_user_cubit.dart';
import 'core/secrets/app_secret.dart';
import 'features/admin/data/repository/admin_repository_imp.dart';
import 'features/admin/domin/repository/admin_repository.dart';
import 'features/admin/domin/usecase/get_all_staff_usecase.dart';
import 'features/admin/domin/usecase/get_room_usecase.dart';
import 'features/admin/domin/usecase/get_sector_usecase.dart';
import 'features/admin/presentation/bloc/room/room_bloc.dart';
import 'features/auth/data/datasource/remote_data_source.dart';
import 'features/auth/data/repository/auth_repository_imp.dart';
import 'features/auth/domin/repository/auth_repository.dart';
import 'features/auth/domin/usecases/current_user_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/customer/domin/repository/customer_repository.dart';
import 'features/customer/domin/usecase/Insert_request_usecase.dart';
import 'features/customer/domin/usecase/get_my_change_room_requests_usecase.dart';
import 'features/customer/domin/usecase/get_my_invoice_usecase.dart';
import 'features/customer/domin/usecase/get_rooms_usecase.dart';
import 'features/customer/presentation/bloc/service/service_bloc.dart';
import 'features/staff/domin/repository/staff_repository.dart';
import 'features/staff/domin/usecase/get_staff_request_usecase.dart';
import 'features/staff/presentation/bloc/staff_request/staff_request_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> intDependcies() async {
  final supabase = await Supabase.initialize(
    url: AppSecret.url,
    anonKey: AppSecret.key,
  );
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  intAuth();
  intAdmin();
  intCustomer();
  intStaff();
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerLazySingleton(() => prefs);

  serviceLocator.registerLazySingleton(() => supabase.client);
}

void intAuth() {
  serviceLocator.registerFactory<RemoteDataSource>(
      () => RemoteDataSourceImp(serviceLocator(), serviceLocator()));

  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImp(serviceLocator()));
  serviceLocator.registerFactory(() => SignInUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => CurrentUserUsecase(serviceLocator()));

  serviceLocator.registerLazySingleton(() => AuthBloc(
      signInUsecase: serviceLocator(),
      appUserCubit: serviceLocator(),
      currentUserUsecase: serviceLocator()));
}

void intAdmin() {
  serviceLocator.registerFactory<AdminRemoteDataSource>(
      () => AdminRemoteDataSourceimp(serviceLocator()));

  serviceLocator.registerFactory<AdminRepository>(
      () => AdminRepositoryImp(serviceLocator()));
  serviceLocator.registerFactory(() => GetRoomsUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => GetSectorUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => InsertUserUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetAllCustomersUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => GetAllStaffUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetAllRoomChangeRequestUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => UpdateRoomChangeRequestUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetCustomerInvoiceUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetStatusUsecase(serviceLocator()));

  serviceLocator.registerFactory(() => RoomBloc(
      getRoomsUsecase: serviceLocator(),
      getAllRoomChangeRequestUsecase: serviceLocator(),
      updateRoomChangeRequestUsecase: serviceLocator()));
  serviceLocator
      .registerFactory(() => SectorBloc(getSectorUsecase: serviceLocator()));

  serviceLocator.registerFactory(() => UserBloc(
      insertUserUsecase: serviceLocator(),
      getAllCustomersUsecase: serviceLocator(),
      getAllStaffUsecase: serviceLocator(),
      getCustomerInvoiceUsecase: serviceLocator(), getStatusUsecase: serviceLocator()));

  serviceLocator
      .registerFactory(() => GetAdminServicesUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => InsertServiceUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => UpdateServiceUsecase(serviceLocator()));

  serviceLocator.registerFactory(() => AdminServiceBloc(
      getAdminServicesUsecase: serviceLocator(),
      insertServiceUsecase: serviceLocator(),
      updateServiceUsecase: serviceLocator()));
}

void intCustomer() {
  serviceLocator.registerFactory<CustomerDataSource>(
      () => CustomerDataSourceImp(serviceLocator()));

  serviceLocator.registerFactory<CustomerRepository>(
      () => CustomerRepositoryImp(serviceLocator()));
  serviceLocator.registerFactory(() => GetAllServicesUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => InsertRequestUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => InsertRoomChangeRequestUsecase(serviceLocator()));

  serviceLocator.registerFactory(() => GetMyRequestsUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetMyChangeRoomRequestsUsecase(serviceLocator()));

  serviceLocator.registerFactory(() => GetMyInvoiceUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetCustomerRoomsUsecase(serviceLocator()));

  serviceLocator.registerFactory(() => RequestBloc(
      insertRequestUsecase: serviceLocator(),
      getMyRequestsUsecase: serviceLocator(),
      getMyInvoiceUsecase: serviceLocator(),
      getRoomsUsecase: serviceLocator(),
      insertRoomChangeRequestUsecase: serviceLocator(),
      getMyChangeRoomRequestsUsecase: serviceLocator()));

  serviceLocator.registerFactory(
      () => ServiceBloc(getAllServicesUsecase: serviceLocator()));
}

void intStaff() {
  serviceLocator.registerFactory<StaffDatasource>(
      () => StaffDatasourceImp(serviceLocator()));

  serviceLocator.registerFactory<StaffRepository>(
      () => StaffRepositoryImp(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetSectorRequestsUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => UpdateRequestUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => UpdateDeilvereRequestUsecase(serviceLocator()));

  serviceLocator
      .registerFactory(() => GetStaffRequestsUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => GetStaffStatusUsecase(serviceLocator()));

  serviceLocator.registerFactory(() => StaffRequestBloc(
      getStaffRequestsUsecase: serviceLocator(),
      updateRequestUsecase: serviceLocator(),
      getSectorRequestsUsecase: serviceLocator(),
      deilvereRequestUsecase: serviceLocator(),
      getStaffStatusUsecase: serviceLocator()));
}
