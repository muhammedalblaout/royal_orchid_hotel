import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/entites/request.dart';
import 'package:royal_orchid_hotel/core/utils/format_date.dart';

import '../../../../core/theme/app_pallete.dart';

class SectorRequestListItem extends StatelessWidget {
  final Request request;

  const SectorRequestListItem({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 18),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: AppPallete.color4.withOpacity(0.8),
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
                  request.service_name!,
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
              height: 8,
            ),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "To : ${request.customer_name}",
                        style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppPallete.color5,
                            fontSize: 10),
                      ),
                      Text(
                        "Price : \$${request.price}",
                        style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppPallete.color5,
                            fontSize: 10),
                      ),
                    ],
                  ),
                  const Center(
                      child: SizedBox(
                          height: 18,
                          child: VerticalDivider(
                            color: AppPallete.text,
                            thickness: 2,
                          ))),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Room: ${request.room_id}",
                        style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppPallete.color5,
                            fontSize: 10),
                      ),
                      Text(
                        "Sector: ${request.sector}",
                        style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppPallete.color5,
                            fontSize: 10),
                      ),
                    ],
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
