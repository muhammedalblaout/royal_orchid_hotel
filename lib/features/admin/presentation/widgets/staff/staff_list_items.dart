import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';

import '../../../../../core/entites/user.dart';

class StaffListItems extends StatelessWidget {
  final User user;

  StaffListItems({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
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
                ]),
            boxShadow: [
              BoxShadow(
                color: AppPallete.color4,
                offset: const Offset(0, 10),
                blurRadius: 10,
                spreadRadius: -5,
              ),
            ]),
        child: Row(
          children: [
            const Icon(
              Icons.person,
              color: AppPallete.backgroundColor,
              size: 100,
            ),
            const SizedBox(
              width: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.name,
                  style: GoogleFonts.poppins().copyWith(
                      color: AppPallete.backgroundColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  user.email,
                  style: GoogleFonts.poppins().copyWith(
                      color: AppPallete.backgroundColor.withOpacity(0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Role: ${user.role == 1 ? "Admin" : "Staff"} | Sector : ${user.sector}",
                  style: GoogleFonts.poppins().copyWith(
                      color: AppPallete.gold,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
