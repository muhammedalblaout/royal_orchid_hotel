import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/entites/request.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';
import 'package:royal_orchid_hotel/core/utils/format_date.dart';

import '../../../../core/commen/widget/plan_widegt.dart';
import '../../../../core/entites/user.dart';
import '../bloc/staff_request/staff_request_bloc.dart';

class RequestInfoPage extends StatefulWidget {
  static route(Request request, User user) =>
      MaterialPageRoute(builder: (context) {
        return RequestInfoPage(
          request: request,
          user: user,
        );
      });
  Request request;
  User user;

  RequestInfoPage({super.key, required this.request, required this.user});

  @override
  State<RequestInfoPage> createState() => _RequestInfoPageState();
}

class _RequestInfoPageState extends State<RequestInfoPage> {
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppPallete.color4,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Service: ${widget.request.service_name}",
                        style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.w900,
                            color: AppPallete.backgroundColor,
                            fontSize: 18),
                      ),
                      Text(
                        "To: ${widget.request.customer_name}",
                        style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppPallete.backgroundColor,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Room: ${widget.request.room_id}",
                        style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppPallete.backgroundColor,
                            fontSize: 14),
                      ),
                      Text(
                        "Sector: ${widget.request.sector}",
                        style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppPallete.backgroundColor,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Ordering Date : ${FormateDate(widget.request.created_at!)}",
                        style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppPallete.backgroundColor,
                            fontSize: 12),
                      ),
                      Text(
                        "Accepted Date : ${FormateDate(widget.request.accepted_at!)}",
                        style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppPallete.backgroundColor,
                            fontSize: 12),
                      ),
                    ],
                  ),
                  const Center(
                    child: Icon(
                      Icons.qr_code_rounded,
                      color: AppPallete.backgroundColor,
                      size: 100,
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: PlanWidget(500, 300, widget.request.room_id),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppPallete.color4,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(AppPallete.backgroundColor),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(color: AppPallete.backgroundColor,width: 1)))),
                      child:  Text("Cancel",style: GoogleFonts.poppins().copyWith(
                        color: AppPallete.color4,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        context.read<StaffRequestBloc>().add(UpdateDeilvereRequestsEvent(widget.request.copyWith(isDelivered: false)));
                        context.read<StaffRequestBloc>().add(GetStaffRequestsEvent(widget.user.id));


                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(AppPallete.reject),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(color: AppPallete.backgroundColor,width: 1)))),
                      child:  Text("Reject",style: GoogleFonts.poppins().copyWith(
                        color: AppPallete.backgroundColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<StaffRequestBloc>().add(UpdateDeilvereRequestsEvent(widget.request.copyWith(isDelivered: true)));
                        context.read<StaffRequestBloc>().add(GetStaffRequestsEvent(widget.user.id));




                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(AppPallete.accept),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(color: AppPallete.backgroundColor,width: 1)))),
                      child:  Text("Confirm",style: GoogleFonts.poppins().copyWith(
                        color: AppPallete.backgroundColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
