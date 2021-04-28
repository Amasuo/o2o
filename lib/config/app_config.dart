import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app_ui_kit/config/app_config.dart' as config;

class App {
  BuildContext _context;
  double _height;
  double _width;
  double _heightPadding;
  double _widthPadding;

  App(_context) {
    this._context = _context;
    MediaQueryData _queryData = MediaQuery.of(this._context);
    _height = _queryData.size.height / 100.0;
    _width = _queryData.size.width / 100.0;
    _heightPadding = _height -
        ((_queryData.padding.top + _queryData.padding.bottom) / 100.0);
    _widthPadding =
        _width - (_queryData.padding.left + _queryData.padding.right) / 100.0;
  }

  double appHeight(double v) {
    return _height * v;
  }

  double appWidth(double v) {
    return _width * v;
  }

  double appVerticalPadding(double v) {
    return _heightPadding * v;
  }

  double appHorizontalPadding(double v) {
    return _widthPadding * v;
  }
}

class Colors {
  Color _mainColor = Color(0xffe31313); //Color(0xFF009DB5);
  Color _mainDarkColor = Color(0xffcd0714); //Color(0xFF22B7CE);
  Color _secondColor = Color(0xff000000); //Color(0xFF04526B);
  Color _secondDarkColor = Color(0xFFE7F6F8);
  Color _accentColor = Color(0xFFADC4C8);
  Color _accentDarkColor = Color(0xFFADC4C8);

  Color mainColor(double opacity) {
    return this._mainColor.withOpacity(opacity);
  }

  Color secondColor(double opacity) {
    return this._secondColor.withOpacity(opacity);
  }

  Color accentColor(double opacity) {
    return this._accentColor.withOpacity(opacity);
  }

  Color mainDarkColor(double opacity) {
    return this._mainDarkColor.withOpacity(opacity);
  }

  Color secondDarkColor(double opacity) {
    return this._secondDarkColor.withOpacity(opacity);
  }

  Color accentDarkColor(double opacity) {
    return this._accentDarkColor.withOpacity(opacity);
  }
}

class MyThemes {
  static final List<ThemeData> themes = [
    ThemeData(
      fontFamily: 'Poppins',
      primaryColor: Color(0xFF252525),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF2C2C2C),
      accentColor: config.Colors().mainDarkColor(1),
      hintColor: config.Colors().secondDarkColor(1),
      focusColor: config.Colors().accentDarkColor(1),
      textTheme: TextTheme(
        button: TextStyle(color: Color(0xFF252525)),
        headline5: TextStyle(
            fontSize: 20.0, color: config.Colors().secondDarkColor(1)),
        headline4: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: config.Colors().secondDarkColor(1)),
        headline3: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: config.Colors().secondDarkColor(1)),
        headline2: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
            color: config.Colors().mainDarkColor(1)),
        headline1: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w300,
            color: config.Colors().secondDarkColor(1)),
        subtitle1: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: config.Colors().secondDarkColor(1)),
        headline6: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: config.Colors().mainDarkColor(1)),
        bodyText2: TextStyle(
            fontSize: 12.0, color: config.Colors().secondDarkColor(1)),
        bodyText1: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: config.Colors().secondDarkColor(1)),
        caption: TextStyle(
            fontSize: 12.0, color: config.Colors().secondDarkColor(0.7)),
      ),
    ),
    ThemeData(
      fontFamily: 'Poppins',
      primaryColor: Color(0xFFFFFFFF),
      brightness: Brightness.light,
      scaffoldBackgroundColor: Color(0xFFF5F5F5),
      accentColor: config.Colors().mainColor(1),
      focusColor: config.Colors().accentColor(1),
      hintColor: config.Colors().secondColor(1),
      textTheme: TextTheme(
        button: TextStyle(color: Color(0xFFFFFFFF)),
        headline5:
            TextStyle(fontSize: 20.0, color: config.Colors().secondColor(1)),
        headline4: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: config.Colors().secondColor(1)),
        headline3: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: config.Colors().secondColor(1)),
        headline2: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
            color: config.Colors().mainColor(1)),
        headline1: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w300,
            color: config.Colors().secondColor(1)),
        subtitle1: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: config.Colors().secondColor(1)),
        headline6: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: config.Colors().mainColor(1)),
        bodyText2:
            TextStyle(fontSize: 12.0, color: config.Colors().secondColor(1)),
        bodyText1: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: config.Colors().secondColor(1)),
        caption:
            TextStyle(fontSize: 12.0, color: config.Colors().secondColor(0.6)),
      ),
    ),
  ];

  static ThemeData getThemeFromIndex(String index) {
    try {
      return themes[int.parse(index)];
    } catch (e) {
      return themes[0];
    }
  }

  static Future<ThemeData> getSavedTheme() async {
    String index = await getSavedThemeIndex();
    return getThemeFromIndex(index != null ? index : "0");
  }

  static Future<String> getSavedThemeIndex() async {
    final pref = await SharedPreferences.getInstance();
    final index = pref.getString("ui_theme");
    return index;
  }
}
