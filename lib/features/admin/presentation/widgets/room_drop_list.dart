import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../../../core/entites/room.dart';

class RoomDropList extends StatefulWidget {
  final IconData icon;
  final List<Room> items;
  final ValueChanged<String> onChanged;


  const RoomDropList({
    super.key,
    required this.icon,
    required this.items,
    required this.onChanged
  });

  @override
  State<RoomDropList> createState() => _RoomDropListState();
}

class _RoomDropListState extends State<RoomDropList> {
  late List<String>rooms;

  String dropdownvalue = " ";

  @override
  void initState() {
    rooms=widget.items.map((e) => e.room_id).toList();
    dropdownvalue = rooms.first;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    border([Color color = AppPallete.color5]) => OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        );
    return Theme(
      data: ThemeData(
          primaryColor: AppPallete.backgroundColor,
          inputDecorationTheme: InputDecorationTheme(
            border: border(),
            focusedBorder: border(),
            errorBorder: border(AppPallete.error),
            hintStyle: GoogleFonts.poppins()
                .copyWith(color: AppPallete.color4, fontSize: 12.0),
            fillColor: AppPallete.backgroundColor,
          )),
      child: DropdownButtonFormField(
          value: dropdownvalue,
          icon: const Icon(Icons.keyboard_arrow_down,color: AppPallete.color5,),
          borderRadius: BorderRadius.circular(3),
          items: rooms.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          isExpanded: true,
          onChanged: (String? newValue) {
            setState(() {
              dropdownvalue = newValue!;
            });
            widget.onChanged(newValue!);

          },style: GoogleFonts.poppins().copyWith(
          color: AppPallete.color5, fontSize: 12.0),
          decoration: InputDecoration(
              prefixIcon: Icon(widget.icon, color: AppPallete.color5),
            filled: true,
            enabledBorder: border()
          ),
      ),
    );
  }
}
