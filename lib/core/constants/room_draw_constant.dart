
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';


Rect get_room_draw(String roomId, double width, double height) {
  int i = RoomMap.room_map[roomId]!;
  if (i <= 6) {
    return Rect.fromPoints(
      Offset(((i - 1) * width / 6) + 2, (height - height / 1.5) - 2),
      Offset((i * width / 6) - 2, 0 + 2),
    );
  } else {
    return Rect.fromPoints(
      Offset(((i - 7) * width / 6) + 2, height - 2),
      Offset(((i - 6) * width / 6) - 2, (height / 1.5) + 2),
    );
  }
}

TextPainter Text_Draw(String text, Size size,double fontsize,Color color) {
  //texts

  final textStyle = GoogleFonts.poppins().copyWith(
      color: color, fontSize: fontsize, fontWeight: FontWeight.bold);
  final EntrancetextSpan = TextSpan(
    text: text,
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
  return EntrancetextPainter;
}

class RoomMap {
  static const Map<String, int> room_map = {
    '101': 1,
    '102': 2,
    '103': 3,
    '104': 4,
    '105': 5,
    '106': 6,
    '107': 7,
    '108': 8,
    '109': 9,
  };
}
