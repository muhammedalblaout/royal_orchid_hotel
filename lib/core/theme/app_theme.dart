import 'package:flutter/material.dart';

import 'app_pallete.dart';

class AppTheme {
  static final Thememode = ThemeData().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      foregroundColor:AppPallete.color4 ,
        backgroundColor: AppPallete.backgroundColor, scrolledUnderElevation: 0),
  );
}
