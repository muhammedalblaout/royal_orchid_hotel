import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';
import 'package:royal_orchid_hotel/core/utils/show_snack_bar.dart';
import 'package:royal_orchid_hotel/features/staff/presentation/page/request_info.dart';

import '../../../../core/commen/cubit/app_user/app_user_cubit.dart';
import '../../../../core/commen/cubit/app_user/app_user_state.dart';
import '../../../../core/widget/loader.dart';
import '../../../../int_dep.dart';
import '../bloc/staff_request/staff_request_bloc.dart';
import '../widgets/sector_request_list_item.dart';

class MyStaffRequestsPage extends StatefulWidget {
  const MyStaffRequestsPage({super.key});

  static route() => MaterialPageRoute(builder: (context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<StaffRequestBloc>()),
      ],
      child: const MyStaffRequestsPage(),
    );
  });

  @override
  State<MyStaffRequestsPage> createState() => _MyStaffRequestsPageState();
}

class _MyStaffRequestsPageState extends State<MyStaffRequestsPage> {
  @override
  void initState() {
    var user = (context.read<AppUserCubit>().state as AppStaffLoggin).user;

    context.read<StaffRequestBloc>().add(GetStaffRequestsEvent(user.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = (context.read<AppUserCubit>().state as AppStaffLoggin).user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Requests",
          style: GoogleFonts.poppins().copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppPallete.color4),
        ),
      ),
      body: BlocConsumer<StaffRequestBloc, StaffRequestState>(
        listener: (context, state) {
          if (state is StaffRequestFail) {
            ErrorShowSnackBar(context, state.massage);
          }
        },
        builder: (context, state) {
          if (state is StaffRequestLoading) {
            return const Loader(
              color: AppPallete.color4,
            );
          }
          if (state is StaffRequestSuccess) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: SectorRequestListItem(request: state.list[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return BlocProvider.value(
                            value: BlocProvider.of<StaffRequestBloc>(context),
                            child: RequestInfoPage(request: state.list[index], user: user,),
                          );
                        },
                      ),
                    );

                  },
                );
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
