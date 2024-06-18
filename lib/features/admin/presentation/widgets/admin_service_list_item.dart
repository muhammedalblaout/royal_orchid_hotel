import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';
import 'package:royal_orchid_hotel/core/entites/service.dart';

class AdminServiceListItem extends StatelessWidget {
  final Service service;

  const AdminServiceListItem({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    Color background= service.available==false?Colors.grey:AppPallete.gold;


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: AppPallete.color4,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: background,
                offset: const Offset(0, 10),
                blurRadius: 10,
                spreadRadius: -5,
              ),
            ],
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  HSVColor.fromColor(background)
                      .withValue(0.8)
                      .toColor(),
                  HSVColor.fromColor(background)
                      .withValue(0.8)
                      .toColor(),
                  background,
                  background
                ],
                stops: const [
                  0.2,
                  0.3,
                  0.9,
                  1.0
                ])
        ),
        width: double.infinity,
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,


          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                const Icon(Icons.room_service,color: AppPallete.backgroundColor,size: 40,),
                const SizedBox(width: 16,),
                Text(
                  service.name,
                  style: GoogleFonts.poppins()
                      .copyWith(color: AppPallete.backgroundColor, fontSize: 16,fontWeight:FontWeight.w900),
                ),


              ],
            ),
            Text(
              "Price: ${service.price}\$",
              style: GoogleFonts.poppins()
                  .copyWith(color: AppPallete.backgroundColor, fontSize: 14,fontWeight:FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
