import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/entites/invoice.dart';
import 'package:royal_orchid_hotel/core/utils/format_date.dart';

import '../../../../../core/theme/app_pallete.dart';


class CustomerInvoiceListItem extends StatelessWidget {
  final Invoice invoice;

  CustomerInvoiceListItem({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 18),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: AppPallete.text.withOpacity(0.8),
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
                  invoice.service_name,
                  style: GoogleFonts.poppins().copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppPallete.color5,
                      fontSize: 20),
                ),
                Text(
                  "\$ ${invoice.price}",
                  style: GoogleFonts.poppins().copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppPallete.color5,
                      fontSize: 20),
                ),
                Text(
                  "Staff : ${invoice.staff_name}",
                  style: GoogleFonts.poppins().copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppPallete.color5,
                      fontSize: 10),
                ),
                Text(
                  "Date : ${FormateDate(invoice.created_at)}",
                  style: GoogleFonts.poppins().copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppPallete.color5,
                      fontSize: 10),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}
