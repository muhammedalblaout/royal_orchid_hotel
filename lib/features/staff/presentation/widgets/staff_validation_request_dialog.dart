import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/entites/request.dart';

import '../../../../core/entites/user.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../bloc/staff_request/staff_request_bloc.dart';

class StaffValidationRequestDialog extends StatefulWidget {
  final Request request;
  final User user;

  const StaffValidationRequestDialog(
      {super.key, required this.request,required this.user});

  @override
  State<StaffValidationRequestDialog> createState() => _OrderDialogState();
}

class _OrderDialogState extends State<StaffValidationRequestDialog> {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<StaffRequestBloc, StaffRequestState>(
        listener: (context, state) {
          if(state is StaffRequestFail){
            ErrorShowSnackBar(context, state.massage);
          }
          if (state is StaffUpdateRequestSuccess) {
            context.read<StaffRequestBloc>().add(GetSectorRequestsEvent(widget.user.sector));
            Navigator.of(context).pop(); // Close the dialog


          }
        },

        builder: (context, state) {

          return  AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            backgroundColor: AppPallete.backgroundColor,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: AppPallete.color4,
                  size: 50,
                ),
                Text(
                  "Are You Sure ?",
                  style: GoogleFonts.poppins().copyWith(
                      color: AppPallete.color4,
                      fontSize: 26.sp,
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
                      "Do you want to accept this request?\n Service: ${widget.request.service_name} \n From: ${widget.request.customer_name}",
                      style: GoogleFonts.poppins().copyWith(
                        color: AppPallete.text,
                        fontSize: 12.sp,
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
                  final Request request = widget.request.copyWith(isAccepted:false,Staff_id: widget.user.id);
                  context.read<StaffRequestBloc>().add(UpdateRequestsEvent(request));

                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppPallete.reject),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: AppPallete.reject,width: 2)))),
                child:  Text("Reject",style: GoogleFonts.poppins().copyWith(
                  color: AppPallete.backgroundColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),),
              ),

              ElevatedButton(
                onPressed: () {
                  final Request request = widget.request.copyWith(isAccepted:true,Staff_id: widget.user.id);
                  context.read<StaffRequestBloc>().add(UpdateRequestsEvent(request));

                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppPallete.accept),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: AppPallete.accept,width: 2)))),
                child:  Text("Confirm",style: GoogleFonts.poppins().copyWith(
                  color: AppPallete.backgroundColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ],
          );
        }
    );
  }
}
