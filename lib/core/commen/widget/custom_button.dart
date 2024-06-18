import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_pallete.dart';

Widget CustomButton(String text, {required VoidCallback onPressed}) {
  return Container(
    width: 395,
    height: 55,
    clipBehavior: Clip.antiAlias,

    decoration: BoxDecoration(
      color: AppPallete.color5,
      borderRadius: BorderRadius.circular(30),

    ),
    child: ElevatedButton(

        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: AppPallete.transparent,
            shape: const StadiumBorder(),
            elevation: 0,
            backgroundColor: AppPallete.transparent,
            fixedSize: const Size(395, 55)),
        child: Text(
          text,
          style:GoogleFonts.poppins().copyWith(fontSize: 18,fontWeight: FontWeight.w800,color: AppPallete.backgroundColor),
        )),
  );
}
