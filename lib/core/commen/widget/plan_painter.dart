


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';

import '../../../../core/constants/room_draw_constant.dart';

class PlanPainter extends CustomPainter {

  double width=350;
  double height=250;
  double height_e=350;



  PlanPainter({required this.room_color,required this.room_id});
  Color room_color;
  String room_id;// final Paint painter = new Paint()


  @override
  void paint(Canvas canvas, Size size) {

    double width=size.width;
    double height=size.height*0.7;
    double heightE=size.height;

    //main_wall
    const p1 = Offset(0, 0);
    final p2 = Offset(width, 0);
    final p3 = Offset(0, height);
    final p4 = Offset(width, height);


    //enter
    final p5 = Offset(width/2, height);
    final p6 = Offset(width/2, heightE);
    final p7 = Offset(width-width/3, height);
    final p8 = Offset(width-width/3, heightE);

    //coridour
    final p9 = Offset(0, height/1.5);
    final p10 = Offset(width/2, height/1.5);
    final p11 = Offset(width-width/3, height/1.5);
    final p12 = Offset(width, height/1.5);
    final p13= Offset(0,height- height/1.5);
    final p14 = Offset(width,height- height/1.5);







    final LinePaint = Paint()
      ..color = AppPallete.gold
      ..strokeWidth = 4;

    final RoomPaint = Paint()
      ..color = room_color ;
    //main_walls & Enter
    canvas.drawLine(p1, p2, LinePaint);
    canvas.drawLine(p1, p3, LinePaint);
    canvas.drawLine(p2, p4, LinePaint);
    canvas.drawLine(p3, p5, LinePaint);

    canvas.drawLine(p7, p4, LinePaint);
    canvas.drawLine(p7, p4, LinePaint);
    canvas.drawLine(p3, p5, LinePaint);
    canvas.drawLine(p10, p6, LinePaint);
    canvas.drawLine(p11, p8, LinePaint);
    canvas.drawLine(p6, p8, LinePaint);

    //coridour
    canvas.drawLine(p9, p10, LinePaint);
    canvas.drawLine(p11, p12, LinePaint);
    canvas.drawLine(p13, p14, LinePaint);
    //rooms
    for(int i=1;i<7;i++){
      final rx12 = Offset(i*width/6, 0);
      final ry12 = Offset(i*width/6,height- height/1.5);


      canvas.drawLine(rx12, ry12, LinePaint);

    }


    for(int i=1;i<4;i++){
      final rx12 = Offset(i*width/6, height/1.5);
      final ry12 = Offset(i*width/6,height);
      canvas.drawLine(rx12, ry12, LinePaint);
    }
    final room= get_room_draw(room_id,  width,  height);

    canvas.drawRect(room, RoomPaint);
    //room_id


    //texts
    for(int i=1;i<10;i++){

      if (i <= 6) {
        Color color =AppPallete.color4;
         var centerX =( ((( ((i-1)*width) / 6))-8) + ((i*width) / 6)) / 2;
         var centerY = ((height - height / 1.5) -8) / 2;
         var offset = Offset(centerX, centerY);
         String key = RoomMap.room_map.keys.firstWhere((k) => RoomMap.room_map[k] == i, orElse: () => "");
         if(key==room_id){
            color =AppPallete.backgroundColor;

         }

         Text_Draw(key,size,8,color).paint(canvas, offset);
      }
      else{
        Color color =AppPallete.color4;
        var centerX =( ((( ((i-7)*width) / 6))-8) + (((i-6)*width) / 6)) / 2;
        var centerY = ((height )+ (height / 1.5)-8) / 2;
        var offset = Offset(centerX, centerY);
        String key = RoomMap.room_map.keys.firstWhere((k) => RoomMap.room_map[k] == i, orElse: () => "");
        if(key==room_id){
          color =AppPallete.backgroundColor;

        }

        Text_Draw(key,size,8,color).paint(canvas, offset);
      }
      }

    const textStyle = TextStyle(
      color: AppPallete.text,
      fontSize: 10,
    );
    const EntrancetextSpan = TextSpan(
      text: 'Entrance',
      style: textStyle,
    );
    final EntrancetextPainter = TextPainter(
      text: EntrancetextSpan,
      textDirection: TextDirection.ltr,
    );
    EntrancetextPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
     var xCenter = 52.5*width/100;
    var yCenter = heightE-heightE*0.2;
    var offset = Offset(xCenter, yCenter);
    Text_Draw('Entrance',size,8,AppPallete.color4).paint(canvas, offset);

     xCenter = 25*width/100;
     yCenter = height-height*0.55;
     offset = Offset(xCenter, yCenter);
    Text_Draw('A',size,14,AppPallete.color4).paint(canvas, offset);

    xCenter = 80*width/100;
    yCenter = height-height*0.55;
    offset = Offset(xCenter, yCenter);
    Text_Draw('B',size,14,AppPallete.color4).paint(canvas, offset);


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}