import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';
import 'package:royal_orchid_hotel/core/utils/show_snack_bar.dart';
import 'package:royal_orchid_hotel/features/customer/presentation/bloc/request/request_bloc.dart';
import 'package:royal_orchid_hotel/features/customer/presentation/bloc/service/service_bloc.dart';
import 'package:royal_orchid_hotel/features/customer/presentation/widget/service_list_item.dart';

import '../../../../core/commen/cubit/app_user/app_user_cubit.dart';
import '../../../../core/commen/cubit/app_user/app_user_state.dart';
import '../../../../core/widget/loader.dart';
import '../../../../int_dep.dart';
import '../widget/order_dialog.dart';

class RequestServicePage extends StatefulWidget {
  const RequestServicePage({super.key});

  static route() => MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<ServiceBloc>()),
            BlocProvider(create: (_) => serviceLocator<RequestBloc>()),

          ],
          child: const RequestServicePage(),
        );
      });

  @override
  State<RequestServicePage> createState() => _RequestServicePageState();
}

class _RequestServicePageState extends State<RequestServicePage> {
  @override
  void initState() {
    context.read<ServiceBloc>().add(GetAllServicesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = (context.read<AppUserCubit>().state as AppCustomerLoggin).user;
    print(user.sector);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Services",
          style: GoogleFonts.poppins().copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppPallete.color4),
        ),
      ),
      body: BlocConsumer<ServiceBloc, ServiceState>(
        listener: (context, state) {
          if (state is ServiceFail) {
            ErrorShowSnackBar(context, state.massage);
          }
        },
        builder: (context, state) {
          if (state is ServiceLoading) {
            return const Loader(
              color: AppPallete.color4,
            );
          }
          if (state is ServiceSuccess) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                    child: ServiceListItem(service: state.list[index]),onTap: (){
                  showDialog(
                    context: context,
                    builder: (_) {
                      return  BlocProvider(

                            create: (_) => serviceLocator<RequestBloc>(),
                            child: OrderDialog(service: state.list[index],user: user,));
                    },
                  );

                },);
              },
              itemCount: state.list.length,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
