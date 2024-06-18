import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/features/customer/presentation/widget/change_room_widget.dart';

import '../../../../core/commen/cubit/app_user/app_user_cubit.dart';
import '../../../../core/commen/cubit/app_user/app_user_state.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../int_dep.dart';
import '../bloc/request/request_bloc.dart';
import '../widget/change_room_info_widget.dart';

class ChangeRoomPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<RequestBloc>()),
          ],
          child: const ChangeRoomPage(),
        );
      });

  const ChangeRoomPage({super.key});

  @override
  State<ChangeRoomPage> createState() => _ChangeRoomPageState();
}

class _ChangeRoomPageState extends State<ChangeRoomPage> {
  @override
  Widget build(BuildContext context) {
    var user = (context.read<AppUserCubit>().state as AppCustomerLoggin).user;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Change Room :",
            style: GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: AppPallete.color4),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 400,
              width: double.infinity,
              child: BlocProvider(
                create: (_) => serviceLocator<RequestBloc>(),
                child: ChangeRoomWidget(
                  user: user,
                  onChanged: (_) {
                    context.read<RequestBloc>().add(GetMyChangeRoomRequestEvent(user_id: user.id));
                  },
                ),
              ),
            ),
            SizedBox(
              height: 350,
              child: ChangeRoomInfoWidget(
                  user: user,

            )
            )
          ],
        ));
  }
}
