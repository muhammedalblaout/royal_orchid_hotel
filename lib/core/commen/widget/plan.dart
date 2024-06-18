import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/commen/widget/plan_painter.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';

import 'package:simple_animations/animation_builder/mirror_animation_builder.dart';

class Plan extends StatefulWidget {
  static route(String roomId) => MaterialPageRoute(builder: (context) {
        return Plan(Room_id: roomId,);
      });
String Room_id;
   Plan({super.key,required this.Room_id});

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  @override
  Widget build(BuildContext context) {
    double width = 350;
    double height = 250;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Room Location ",
          style: GoogleFonts.poppins().copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,

              color: AppPallete.color4),textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppPallete.color2,
              ),
              child: MirrorAnimationBuilder<Color?>(
                tween: ColorTween(
                    begin: AppPallete.error, end: AppPallete.color4),
                duration: const Duration(seconds: 5),
                curve: Curves.linear,
                builder: (context, value, child) {
                  return CustomPaint(
                    painter: PlanPainter(room_color: value!,room_id: widget.Room_id),
                    size: Size(width, height),
                    child: Container(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
