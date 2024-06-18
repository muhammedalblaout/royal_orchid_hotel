import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_orchid_hotel/core/theme/app_theme.dart';
import 'package:royal_orchid_hotel/features/admin/presentation/page/admin_home_page.dart';
import 'package:royal_orchid_hotel/features/auth/presentation/pages/login_page.dart';
import 'package:royal_orchid_hotel/features/customer/presentation/page/customer_home_page.dart';
import 'package:royal_orchid_hotel/features/staff/presentation/page/staff_home_page.dart';

import 'core/commen/cubit/app_user/app_user_cubit.dart';
import 'core/commen/cubit/app_user/app_user_state.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'int_dep.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await intDependcies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_)=> serviceLocator<AppUserCubit>()),
      BlocProvider(create: (_)=> serviceLocator<AuthBloc>()),],

    child:
    const MyApp(),

  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedInEvent());

    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.Thememode,
      home:ScreenUtilInit(
        minTextAdapt: true,

        child: BlocBuilder<AppUserCubit,AppUserState>(
        
          builder: (context,state){
        if( state is AppAdminLoggin){
          return BlocProvider.value(
            value:
            BlocProvider.of<AppUserCubit>(this.context),
            child: const AdminHomePage(),
          );
        }
        else if( state is AppCustomerLoggin){
          return BlocProvider.value(
            value:
            BlocProvider.of<AppUserCubit>(this.context),
            child: const CustomerHomePage(),
          );
        }
        else if( state is AppStaffLoggin){
          return BlocProvider.value(
            value:
            BlocProvider.of<AppUserCubit>(this.context),
            child: const StaffHomePage(),
          );
        }
        else {
          return BlocProvider.value(
            value:
            BlocProvider.of<AppUserCubit>(this.context),
            child: const LoginPage(),
          );
        }
        
            },
        
        ),
      )    );
  }
}

