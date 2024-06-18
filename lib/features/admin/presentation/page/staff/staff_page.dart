import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';
import 'package:royal_orchid_hotel/core/utils/show_snack_bar.dart';
import 'package:royal_orchid_hotel/core/widget/loader.dart';
import 'package:royal_orchid_hotel/features/admin/presentation/page/staff/staff_details_page.dart';

import '../../../../../int_dep.dart';
import '../../bloc/user/user_bloc.dart';
import '../../widgets/staff/staff_list_items.dart';

class StaffPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<UserBloc>()),
          ],
          child: const StaffPage(),
        );
      });

  const StaffPage({super.key});

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  @override
  void initState() {
    context.read<UserBloc>().add(GetAllStaffEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Staff",
        style: GoogleFonts.poppins().copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppPallete.color4),
      )),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserFail) {
            ErrorShowSnackBar(context, state.massage);
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return const Loader(color: AppPallete.color4);
          }
          if (state is DisplayUsersSuccess) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: StaffListItems(user: state.users[index]),
                  onTap: () {
                    if(state.users[index].role==1){
                      ErrorShowSnackBar(context, "You do not have the permissions to access this account information") ;
                    }
                    else{
                      Navigator.push(context, StaffDetailsPage.route(state.users[index]));

                    }
                  },
                );
              },
              itemCount: state.users.length,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
