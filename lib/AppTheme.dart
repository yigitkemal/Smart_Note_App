import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_text_recognititon/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: createMaterialColor(PrimaryBackgroundColor),
    primaryColor: PrimaryBackgroundColor,
    scaffoldBackgroundColor: PrimaryBackgroundColor,
    fontFamily: GoogleFonts.poppins().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.white),
    iconTheme: IconThemeData(color: scaffoldColorDark),
    textTheme: TextTheme(headline6: TextStyle(color: scaffoldColorDark)),
    dialogBackgroundColor: Colors.white,
    unselectedWidgetColor: Colors.black,
    dividerColor: viewLineColor,
    cardColor: PrimaryBackgroundColor,
    canvasColor: PrimaryBackgroundColor,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: scaffoldColorDark),
      backgroundColor: PrimaryBackgroundColor,
      brightness: Brightness.light,
    ),
    scrollbarTheme: ScrollbarThemeData(thumbColor: MaterialStateProperty.all(scaffoldColorDark), radius: Radius.circular(8)),
    dialogTheme: DialogTheme(shape: dialogShape()),
  ).copyWith(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: createMaterialColor(PrimaryColor),
    primaryColor: appButtonColorDark,
    scaffoldBackgroundColor: scaffoldColorDark,
    fontFamily: GoogleFonts.poppins().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: scaffoldColorDark),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: scaffoldColorDark),
    iconTheme: IconThemeData(color: PrimaryColor),
    textTheme: TextTheme(headline6: TextStyle(color: PrimaryColor)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: scaffoldColorDark),
    dialogBackgroundColor: scaffoldColorDark,
    unselectedWidgetColor: Colors.white60,
    dividerColor: Colors.white12,
    cardColor: scaffoldColorDark,
    canvasColor: scaffoldColorDark,
    scrollbarTheme: ScrollbarThemeData(thumbColor: MaterialStateProperty.all(PrimaryColor), radius: Radius.circular(8)),
    appBarTheme: AppBarTheme(
      backgroundColor: scaffoldColorDark,
      iconTheme: IconThemeData(color: PrimaryColor),
      brightness: Brightness.dark,
    ),
    dialogTheme: DialogTheme(shape: dialogShape()),
  ).copyWith(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
