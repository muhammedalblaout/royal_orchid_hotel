import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';
import 'package:royal_orchid_hotel/core/utils/show_snack_bar.dart';
import 'package:royal_orchid_hotel/features/admin/presentation/bloc/room/room_bloc.dart';
import 'package:royal_orchid_hotel/features/admin/presentation/bloc/service/service_bloc.dart';
import 'package:royal_orchid_hotel/features/admin/presentation/widgets/service_dialog.dart';
import '../../../../core/widget/loader.dart';
import '../../../../int_dep.dart';
import '../widgets/admin_service_list_item.dart';

class AdminServicePage extends StatefulWidget {
  const AdminServicePage({super.key});

  static route() => MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<AdminServiceBloc>()),
          ],
          child: const AdminServicePage(),
        );
      });

  @override
  State<AdminServicePage> createState() => _AdminServicePageState();
}

class _AdminServicePageState extends State<AdminServicePage> {
  @override
  void initState() {
    context.read<AdminServiceBloc>().add(GetAdminServiceEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Services: ",
          style: GoogleFonts.poppins().copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppPallete.color4),
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(right: 20.0, top: 10.0, bottom: 10.0),
            child: GestureDetector(
              child: Container(
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: AppPallete.color4,
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return BlocProvider(
                        create: (_) => serviceLocator<AdminServiceBloc>(),
                        child: ServiceDialog(onChanged: (_) {
                          context
                              .read<AdminServiceBloc>()
                              .add(GetAdminServiceEvent());
                        }));
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: BlocConsumer<AdminServiceBloc, AdminServiceState>(
        listener: (context, state) {
          if (state is AdminServiceFail) {
            ErrorShowSnackBar(context, state.massage);
          }
        },
        builder: (context, state) {
          if (state is RoomLoading) {
            return const Loader(
              color: AppPallete.color4,
            );
          }
          if (state is AdminServiceSuccess) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: AdminServiceListItem(
                    service: state.list[index],
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return BlocProvider(
                            create: (_) => serviceLocator<AdminServiceBloc>(),
                            child: ServiceDialog(
                              service: state.list[index],
                              onChanged: (_) {
                                context
                                    .read<AdminServiceBloc>()
                                    .add(GetAdminServiceEvent());
                              },
                            ));
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
