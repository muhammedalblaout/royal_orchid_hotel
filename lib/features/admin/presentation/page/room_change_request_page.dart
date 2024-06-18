import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';
import 'package:royal_orchid_hotel/core/utils/show_snack_bar.dart';
import 'package:royal_orchid_hotel/features/admin/presentation/bloc/room/room_bloc.dart';
import '../../../../core/widget/loader.dart';
import '../../../../int_dep.dart';
import '../widgets/room_change_dialog.dart';
import '../widgets/room_change_request_list_item.dart';

class RoomChangeRequestPage extends StatefulWidget {
  const RoomChangeRequestPage({super.key});

  static route() => MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<RoomBloc>()),

          ],
          child: const RoomChangeRequestPage(),
        );
      });

  @override
  State<RoomChangeRequestPage> createState() => _RoomChangeRequestPageState();
}

class _RoomChangeRequestPageState extends State<RoomChangeRequestPage> {
  @override
  void initState() {
    context.read<RoomBloc>().add(GetAllRoomChangeRequestsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Requests: ",
          style: GoogleFonts.poppins().copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppPallete.color4),
        ),
      ),
      body: BlocConsumer<RoomBloc, RoomState>(
        listener: (context, state) {
          if (state is RoomFaill) {
            ErrorShowSnackBar(context, state.massage);
          }
        },
        builder: (context, state) {
          if (state is RoomLoading) {
            return const Loader(
              color: AppPallete.color4,
            );
          }
          if (state is DisplayRoomChangeRequewstSuccess) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                    child: RoomChangeRequestListItem( request: state.list[index],),onTap: (){
                  showDialog(
                    context: context,
                    builder: (_) {
                      return  BlocProvider(

                          create: (_) => serviceLocator<RoomBloc>(),
                          child:RoomChangeRequestDialog(request: state.list[index], onChanged: (_) {    context.read<RoomBloc>().add(GetAllRoomChangeRequestsEvent());
                          },));
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
