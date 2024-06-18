import 'package:flutter/cupertino.dart';
import 'package:royal_orchid_hotel/core/commen/widget/plan_painter.dart';
import 'package:simple_animations/animation_builder/mirror_animation_builder.dart';

import '../../theme/app_pallete.dart';

Widget PlanWidget(double width , double height,String roomId){
  return  Container(
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
          painter: PlanPainter(room_color: value!,room_id:roomId),
          size: Size(width, height),
          child: Container(),
        );
      },
    ),
  );
}