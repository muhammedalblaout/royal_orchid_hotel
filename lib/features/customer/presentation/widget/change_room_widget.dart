import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/utils/show_snack_bar.dart';
import 'package:royal_orchid_hotel/features/customer/presentation/widget/room_dialog.dart';

import '../../../../core/entites/room_change_request.dart';
import '../../../../core/entites/user.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../int_dep.dart';
import '../bloc/request/request_bloc.dart';

class ChangeRoomWidget extends StatefulWidget {
  final User user;
  final ValueChanged onChanged;


  const ChangeRoomWidget({super.key, required this.user, required this.onChanged});

  @override
  State<ChangeRoomWidget> createState() => _ChangeRoomWidgetState();
}

class _ChangeRoomWidgetState extends State<ChangeRoomWidget> {
  String toRoomId = '--';

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestBloc, RequestState>(
      listener: (context, state) {
        if(state is InsertRequestSuccess){
          SuccessShowSnackBar(context, 'Your request has been submitted to the administration');

        }
        if(state is RequestFail){
          ErrorShowSnackBar(context, state.massage);

        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Container(
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: AppPallete.color4,
              borderRadius: BorderRadius.circular(42),
              boxShadow: const [
                BoxShadow(
                  color: AppPallete.color4,
                  offset: Offset(0, 10),
                  blurRadius: 10,
                  spreadRadius: -5,
                ),
              ],
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  colors: [
                    HSVColor.fromColor(AppPallete.color4)
                        .withValue(0.8)
                        .toColor(),
                    HSVColor.fromColor(AppPallete.color4)
                        .withValue(0.8)
                        .toColor(),
                    AppPallete.color4,
                    AppPallete.color4
                  ],
                  stops: const [
                    0.2,
                    0.3,
                    0.9,
                    1.0
                  ])),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Change Room",
                style: GoogleFonts.poppins().copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: AppPallete.backgroundColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Current Room:",
                    style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppPallete.backgroundColor),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppPallete.backgroundColor),
                    child: Text(
                      widget.user.room,
                      style: GoogleFonts.poppins().copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppPallete.color4),
                    ),
                  ),
                ],
              ),
              Text(
                "TO:",
                style: GoogleFonts.poppins().copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppPallete.backgroundColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Choose a Room:",
                    style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppPallete.backgroundColor),
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppPallete.backgroundColor),
                      child: Text(
                        ' $toRoomId',
                        style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppPallete.color4),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return BlocProvider(
                              create: (_) => serviceLocator<RequestBloc>(),
                              child: RoomDialog(
                                onChanged: (String value) {
                                  setState(() {
                                    toRoomId = value;
                                  });
                                  print(value);
                                },
                              ));
                        },
                      );
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Center(
                  child: ElevatedButton(
                    onPressed: () {
                      final RoomChangeRequest request = RoomChangeRequest(
                          to_room_id: toRoomId, customer_id: widget.user.id);
                      context.read<RequestBloc>().add(
                          InsertRoomChangeRequestEvent(request: request));
                      widget.onChanged({

                      });
                    },
                    child: Text(
                      "Apply Request",
                      style: GoogleFonts.poppins().copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppPallete.color4),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
