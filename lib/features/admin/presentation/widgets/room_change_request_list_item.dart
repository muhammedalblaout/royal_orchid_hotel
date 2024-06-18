import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/entites/room_change_request.dart';
import 'package:royal_orchid_hotel/core/utils/format_date.dart';

import '../../../../core/theme/app_pallete.dart';

class RoomChangeRequestListItem extends StatelessWidget {
  final RoomChangeRequest request;

  const RoomChangeRequestListItem({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 18),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color:  AppPallete.color4.withOpacity(0.8),
                  blurRadius: 3,
                  spreadRadius: 1)
            ],
            color: AppPallete.backgroundColor,
            borderRadius: BorderRadius.circular(12)),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 "${request.customer_name}",
                  style: GoogleFonts.poppins().copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppPallete.color5,
                      fontSize: 20),
                ),

                Text(
                  "Created At : ${FormateDate(request.created_at!)}",
                  style: GoogleFonts.poppins().copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppPallete.color5.withOpacity(0.6),
                      fontSize: 10),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "From : ${request.from_room_id}",
                    style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppPallete.color5,
                        fontSize: 14),
                  ),
                  const Icon(Icons.arrow_forward_rounded),
                  Text(
                    "To : ${request.to_room_id}",
                    style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppPallete.color5,
                        fontSize: 14),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
