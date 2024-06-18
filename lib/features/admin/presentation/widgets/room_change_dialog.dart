import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/entites/room_change_request.dart';
import 'package:royal_orchid_hotel/core/utils/show_snack_bar.dart';
import 'package:royal_orchid_hotel/features/admin/presentation/bloc/room/room_bloc.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widget/loader.dart';

class RoomChangeRequestDialog extends StatefulWidget {
  final RoomChangeRequest request;
  final ValueChanged<void> onChanged;

  const RoomChangeRequestDialog(
      {super.key, required this.request, required this.onChanged});

  @override
  State<RoomChangeRequestDialog> createState() =>
      _RoomChangeRequestDialogState();
}

class _RoomChangeRequestDialogState extends State<RoomChangeRequestDialog> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomBloc, RoomState>(listener: (context, state) {
      if (state is RoomFaill) {
        ErrorShowSnackBar(context, state.massage);
      }
    }, builder: (context, state) {
      if (state is RoomLoading) {
        return const Center(
            child: Loader(
          color: AppPallete.color4,
        ));
      }
      if (state is UpdateRoomChangeSuccess) {
        widget.onChanged(());
        return SimpleDialog(
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppPallete.color4,
                    size: 50,
                  ),
                  Text(
                    "Room Change Confirmed",
                    style: GoogleFonts.poppins().copyWith(
                        color: AppPallete.color4,
                        fontSize: 26,
                        fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        );
      }
      return AlertDialog(
        backgroundColor: AppPallete.backgroundColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: AppPallete.color4,
              size: 50,
            ),
            Text(
              "Are You Sure ?",
              style: GoogleFonts.poppins().copyWith(
                  color: AppPallete.color4,
                  fontSize: 26,
                  fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "To Change Customer: ${widget.request.customer_name} Room?\n From: ${widget.request.from_room_id} \n To: ${widget.request.to_room_id}",
                  style: GoogleFonts.poppins().copyWith(
                    color: AppPallete.text,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              RoomChangeRequest roomChangeRequest =
                  widget.request.copyWith(is_accepted: false);
              context
                  .read<RoomBloc>()
                  .add(UpdateRoomChangeRequestEvent(roomChangeRequest));
              Navigator.of(context).pop(); // Close the dialog
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppPallete.reject),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: AppPallete.reject, width: 2)))),
            child: Text(
              "Reject",
              style: GoogleFonts.poppins().copyWith(
                color: AppPallete.backgroundColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              RoomChangeRequest roomChangeRequest =
                  widget.request.copyWith(is_accepted: true);
              context
                  .read<RoomBloc>()
                  .add(UpdateRoomChangeRequestEvent(roomChangeRequest));
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppPallete.accept),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: AppPallete.accept, width: 2)))),
            child: Text(
              "Confirm",
              style: GoogleFonts.poppins().copyWith(
                color: AppPallete.backgroundColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    });
  }
}
