import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';
import 'package:royal_orchid_hotel/core/utils/show_snack_bar.dart';

import '../../../../core/commen/cubit/app_user/app_user_cubit.dart';
import '../../../../core/commen/cubit/app_user/app_user_state.dart';
import '../../../../core/widget/loader.dart';
import '../../../../int_dep.dart';
import '../bloc/staff_request/staff_request_bloc.dart';
import '../widgets/sector_request_list_item.dart';
import '../widgets/staff_validation_request_dialog.dart';

class MySectorRequestsPage extends StatefulWidget {
  const MySectorRequestsPage({super.key});

  static route() => MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<StaffRequestBloc>()),
          ],
          child: const MySectorRequestsPage(),
        );
      });

  @override
  State<MySectorRequestsPage> createState() => _MySectorRequestsPageState();
}

class _MySectorRequestsPageState extends State<MySectorRequestsPage> {
  @override
  void initState() {
    var user = (context.read<AppUserCubit>().state as AppStaffLoggin).user;

    context.read<StaffRequestBloc>().add(GetSectorRequestsEvent(user.sector));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = (context.read<AppUserCubit>().state as AppStaffLoggin).user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Requests",
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
                    showDialog(
                      context: context,
                      builder: (_) {
                        return  BlocProvider.value(
                          value: BlocProvider.of<StaffRequestBloc>(context),
                            child: StaffValidationRequestDialog(request: state.list[index],user: user,));
                      },
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
