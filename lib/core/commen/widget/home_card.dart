import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCard extends StatelessWidget {
  final VoidCallback onTap;
  final Color color1;
  final Color color2;

  final IconData iconData;
  final String title;

  const HomeCard(
      {super.key,
        required this.onTap,
        required this.color1,
        required this.color2,
        required this.iconData,
        required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(24),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: color1,
            borderRadius: BorderRadius.circular(42),
          boxShadow: [
            BoxShadow(
              color: color1,
              offset: const Offset(0, 10),
              blurRadius: 10,
              spreadRadius: -5,
            ),
          ],
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  HSVColor.fromColor(color1).withValue(0.8).toColor(),
                  HSVColor.fromColor(color1).withValue(0.8).toColor(),
                  color1,
                  color1
                ],
                stops: const [
                  0.2,
                  0.3,
                  0.9,
                  1.0
                ])
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                iconData,
                color: color2,
                size: 40.sp,
              ),
              const SizedBox(height: 4,),
              Text(
                title,
                style: GoogleFonts.poppins().copyWith(
                  fontSize: 14,
                  color: color2,
                  fontWeight: FontWeight.w700
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
