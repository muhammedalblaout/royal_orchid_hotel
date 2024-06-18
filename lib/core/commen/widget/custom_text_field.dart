import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_pallete.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final TextEditingController textEditingController;
  final bool isPassword;
  final TextInputType textInputType;


  const CustomTextField({super.key,
    required this.hint,
    required this.icon,
    required this.isPassword,
    required this.textEditingController,
    this.textInputType=TextInputType.text});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final ValueNotifier<bool> _textFiledIsFocused = ValueNotifier(false);

  late final FocusNode _textFieldFocus = FocusNode()
    ..addListener(() {
      _textFiledIsFocused.value = _textFieldFocus.hasFocus;
    });
  bool isUnVisible = false;

  @override
  void initState() {
    isUnVisible = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    border([Color color = AppPallete.transparent]) =>
        OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        );
    return ValueListenableBuilder<bool>(
      valueListenable: _textFiledIsFocused,
      builder: (context, value, child) =>
          Theme(
            data: ThemeData(
                primaryColor: AppPallete.backgroundColor,
                inputDecorationTheme: InputDecorationTheme(
                  border: border(),
                  focusedBorder: border(),
                  errorBorder: border(AppPallete.error),
                  hintStyle: GoogleFonts.poppins().copyWith(
                      color: AppPallete.color5, fontSize: 12.0),

                )),
            child: TextFormField(
              keyboardType:widget.textInputType,
              controller: widget.textEditingController,
              obscureText: isUnVisible,
              focusNode: _textFieldFocus,
              decoration: InputDecoration(
                  hintText: widget.hint,
                  suffixIcon: widget.isPassword
                      ? IconButton(
                    icon: Icon(
                      isUnVisible
                          ? Icons.visibility_off
                          : Icons.remove_red_eye_sharp,
                      color: AppPallete.color5,
                    ),
                    onPressed: () {
                      setState(() {
                        isUnVisible = !isUnVisible;
                      });
                    },
                  )
                      : null,
                  prefixIcon: Icon(
                    widget.icon,
                    color: AppPallete.color5,
                  ),
                  fillColor: AppPallete.backgroundColor,
                  filled: true,
                  focusedBorder: border(AppPallete.color5),
                  border: border(AppPallete.color2)),
              style: GoogleFonts.poppins()
                  .copyWith(color: AppPallete.color5, fontSize: 12.0),
              validator: (value) {
                if (value!.isEmpty) {
                  return "${widget.hint} is missing";
                }
                return null;
              },
            ),
          ),
    );
  }
}
