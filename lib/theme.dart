import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppTheme {
  AppTheme._();

  static final Color _lightPrimaryColor = Colors.blueGrey.shade50;
  static final Color _lightOnPrimaryColor = Colors.blueGrey.shade200;
  static const Color _lightTextColorPrimary = Colors.black;
  static const Color _appbarColorLight = Colors.blue;

  static final Color _darkPrimaryColor = Color(252525);

  static final Color _darkOnPrimaryColor = Color(252525);
  static const Color _darkTextColorPrimary = Colors.white;
  static final Color _appbarColorDark = Colors.blueGrey.shade800;

  static const Color _iconColor = Colors.white;
  static final Color _accentColorDark = HexColor('#7A869E');

  static final Color addCardColor = HexColor('#484E48');
  static final Color addCardPlusColor = HexColor('#53A056');

  static final Color tagHeartColor = HexColor('#AE2323');
  static final Color tagEmailColor = HexColor('#BBAD66');
  static final Color tagWebColor = HexColor('#3555A8');

  static const TextStyle _lightHeadingText = TextStyle(
    color: _lightTextColorPrimary,
    fontFamily: "Inter",
    fontSize: 25,
    fontStyle: FontStyle.italic,
    // fontWeight: FontWeight.bold
  );
  static const TextStyle _lightBodyText = TextStyle(
      color: _lightTextColorPrimary,
      fontFamily: "Inter",
      fontWeight: FontWeight.bold,
      fontSize: 25);
  static const TextTheme _lightTextTheme = TextTheme(
    headlineMedium: _lightHeadingText,
    bodyMedium: _lightBodyText,
  );

  static final TextStyle _darkThemeHeadingTextStyle =
      _lightHeadingText.copyWith(color: _darkTextColorPrimary);

  static final TextStyle _darkThemeBodyeTextStyle =
      _lightBodyText.copyWith(color: _darkTextColorPrimary);

  static final TextTheme _darkTextTheme = TextTheme(
    headlineSmall: _darkThemeHeadingTextStyle,
    bodyMedium: _darkThemeBodyeTextStyle,
  );

  static final LinearGradient filterContainerBackgroundGradient =
      LinearGradient(
    colors: [
      HexColor('#D9D9D9').withOpacity(0),
      HexColor('#5C6476').withOpacity(0.52),
    ],
  );

  static final LinearGradient searchContainerBackgroundGradient =
      LinearGradient(
    colors: [
      HexColor('#5C6476').withOpacity(0.52),
      HexColor('#D9D9D9').withOpacity(0),
    ],
  );

  static final LinearGradient textFieldGradient = LinearGradient(
    colors: [
      HexColor('#5C6476').withOpacity(0),
      HexColor('#5C6476').withOpacity(1),
    ],
    begin: Alignment(0, -1),
    end: Alignment(0, 1),
  );

  static final AssetImage backgroundImage =
      AssetImage('assets/images/background.png');

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightPrimaryColor,
    appBarTheme: const AppBarTheme(
        color: _appbarColorLight, iconTheme: IconThemeData(color: _iconColor)),
    bottomAppBarTheme: BottomAppBarTheme(color: _appbarColorLight),
    colorScheme: ColorScheme.light(
        primary: _lightPrimaryColor,
        onPrimary: _lightOnPrimaryColor,
        secondary: _accentColorDark),
    textTheme: _lightTextTheme,
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkPrimaryColor,
    appBarTheme: AppBarTheme(
        color: _appbarColorDark,
        iconTheme: const IconThemeData(color: _iconColor)),
    bottomAppBarTheme: BottomAppBarTheme(color: _appbarColorDark),
    colorScheme: ColorScheme.dark(
      primary: _darkPrimaryColor,
      secondary: _accentColorDark,
      onPrimary: _darkOnPrimaryColor,
    ),
    textTheme: _darkTextTheme,
  );

  static final cupertinoDarkTheme = CupertinoThemeData(
    scaffoldBackgroundColor: _darkOnPrimaryColor,
    barBackgroundColor: _appbarColorDark,
    primaryColor: _darkPrimaryColor,
    // textTheme: _darkTextTheme,
    primaryContrastingColor: _accentColorDark,
  );
}
