import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppTheme {
  AppTheme._();
  static const Color _lightTextColorPrimary = Colors.black;
  // static final Color _darkPrimaryColor = Colors.grey;

  static final Color _darkOnPrimaryColor = Color(252525);
  static final Color _darkPrimaryColor = Color.fromARGB(255, 37, 37, 37);

  // static final Color _darkOnPrimaryColor = HexColor('#252525');
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
  );
  static const TextStyle _lightBodyText = TextStyle(
      color: _lightTextColorPrimary,
      fontFamily: "Inter",
      fontWeight: FontWeight.bold,
      fontSize: 25);

  static final TextStyle _darkThemeHeadingTextStyle =
      _lightHeadingText.copyWith(color: _darkTextColorPrimary);

  static final TextStyle _darkThemeBodyeTextStyle =
      _lightBodyText.copyWith(color: _darkTextColorPrimary);

  static final TextTheme _darkTextTheme = TextTheme(
    headlineSmall: _darkThemeHeadingTextStyle,
    bodyMedium: _darkThemeBodyeTextStyle,
  );

  static final SnackBarThemeData _snackBarTheme = SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    elevation: 5,
    backgroundColor: Color.fromARGB(255, 34, 34, 34),
  );

  static final TextStyle darkSnackBarTextStyle =
      TextStyle(color: Colors.white, fontSize: 15);

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

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkPrimaryColor,
    primaryColor: _darkPrimaryColor,
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
    snackBarTheme: _snackBarTheme,
    dividerColor: Colors.grey.withOpacity(0.4),
    splashColor: _accentColorDark
  );

  static final cupertinoDarkTheme = CupertinoThemeData(
    scaffoldBackgroundColor: _darkOnPrimaryColor,
    barBackgroundColor: _appbarColorDark,
    primaryColor: _darkPrimaryColor,
    primaryContrastingColor: _accentColorDark,
  );
}
