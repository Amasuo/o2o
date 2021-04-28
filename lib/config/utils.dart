import 'package:ecommerce_app_ui_kit/config/Keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// User Token
Future<void> saveUserToken(String token) async {
  print('save user Token ');
  final pref = await SharedPreferences.getInstance();
  pref.setString(Keys.usertoken, token);
}

Future<void> isfacebooklogin() async {
  final pref = await SharedPreferences.getInstance();
  pref.setBool(Keys.isfacebooklogin, true);
}

Future<void> isgooglelogin() async {
  final pref = await SharedPreferences.getInstance();
  pref.setBool(Keys.isfacebooklogin, true);
}

Future<bool> getisfacebooklogin() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getBool(Keys.isfacebooklogin);
}

Future<bool> getisgooglelogin() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getBool(Keys.isgooglelogin);
}

Future<void> saveUserRefrechToken(String refrechtoken) async {
  print('save user refresh Token ');
  final pref = await SharedPreferences.getInstance();
  pref.setString(Keys.refreshToken, refrechtoken);
}

Future<String> getUserToken() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString(Keys.usertoken);
}

Future<String> getUserRefrechToken() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString(Keys.refreshToken);
}

Future<void> saveUserInfo(String user) async {
  final pref = await SharedPreferences.getInstance();
  pref.setString('INFO', user);
}

Future<String> getUserInfo() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString('INFO');
}

Future<void> clearPref() async {
  await saveUserToken(null);
  await saveUserRefrechToken(null);
  await saveUserInfo(null);
}

void loadingDialog(
  BuildContext context,
) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoPopupSurface(
            isSurfacePainted: false,
            child: Container(height: 100, child: Text("")),
          ));
}

Widget getImage(String imgName) {
  return Container(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.asset(
        imgName ?? "assets/Icon/staue.jpg",
        width: 100,
        height: 100,
      ),
    ),
  );
}

Future<T> showBarModalBottomSheet<T>({
  @required BuildContext context,
  @required WidgetBuilder builder,
  Color backgroundColor,
  double elevation,
  ShapeBorder shape,
  double closeProgressThreshold,
  Clip clipBehavior,
  Color barrierColor = Colors.black87,
  bool bounce = true,
  bool expand = false,
  AnimationController secondAnimation,
  Curve animationCurve,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  Widget topControl,
  Duration duration,
}) async {
  assert(context != null);
  assert(builder != null);
  assert(expand != null);
  assert(useRootNavigator != null);
  assert(isDismissible != null);
  assert(enableDrag != null);
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));
  final result = await Navigator.of(context, rootNavigator: useRootNavigator)
      .push(ModalBottomSheetRoute<T>(
    builder: builder,
    bounce: bounce,
    closeProgressThreshold: closeProgressThreshold,
    containerBuilder: (_, __, child) => BarBottomSheet(
      child: child,
      control: topControl,
      clipBehavior: clipBehavior,
      shape: shape,
      elevation: elevation,
    ),
    secondAnimationController: secondAnimation,
    expanded: expand,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    isDismissible: isDismissible,
    modalBarrierColor: barrierColor,
    enableDrag: enableDrag,
    animationCurve: animationCurve,
    duration: duration,
  ));
  return result;
}
