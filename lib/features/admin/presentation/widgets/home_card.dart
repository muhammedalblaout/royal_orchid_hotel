import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCard extends StatelessWidget {
  VoidCallback onTap;
  Color color1;
  Color color2;

  IconData iconData;
  String title;

  HomeCard(
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
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: color1,
          borderRadius: BorderRadius.circular(4)
        ),
        height: 100,
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                Icon(
                  iconData,
                  color: color2,
                  size: 40,
                ),
                Text(
                  title,
                  style: GoogleFonts.poppins().copyWith(
                    fontSize: 10,
                    color: color2,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
