import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_pallete.dart';

class SectorDropList extends StatefulWidget {
  final IconData icon;
  final List<String> items;
  final ValueChanged<String> onChanged;


  const SectorDropList({
    super.key,
    required this.icon,
    required this.items,
    required this.onChanged
  });

  @override
  State<SectorDropList> createState() => _SectorDropListState();
}

class _SectorDropListState extends State<SectorDropList> {
  String dropdownvalue = " ";

  @override
  void initState() {
    dropdownvalue = widget.items.first;
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
          items: widget.items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
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
