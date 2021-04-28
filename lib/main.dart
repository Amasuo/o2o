import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:ecommerce_app_ui_kit/config/app_config.dart';
import 'package:ecommerce_app_ui_kit/route_generator.dart';
import 'package:ecommerce_app_ui_kit/src/Controller/Location_Picker_Controller.dart';
import 'package:ecommerce_app_ui_kit/src/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'src/Provider/Location_Picker_Provider.dart';

import 'package:ecommerce_app_ui_kit/src/Services/Binding.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => MyThemes.themes[1],
        themedWidgetBuilder: (context, theme) {
          return OKToast(
              child: GetMaterialApp(
                title: 'Siyou Online',
                initialRoute: '/LogIn',
                onGenerateRoute: RouteGenerator.generateRoute,
                debugShowCheckedModeBanner: false,
                theme: theme,
                initialBinding: Binding(),
                builder: (BuildContext context, Widget child){
                  return FlutterSmartDialog(child : child);
                },
              )
          );
        }
    );
    /*return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => MyThemes.themes[1],
        themedWidgetBuilder: (context, theme) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => LocationProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => LocationProvider(),
                ),
              ],
              child: MaterialApp(
                title: 'Siyou Online',
                initialRoute: '/Tabs',
                onGenerateRoute: RouteGenerator.generateRoute,
                debugShowCheckedModeBanner: false,
                theme: theme,
              ));
        });*/
  }
}