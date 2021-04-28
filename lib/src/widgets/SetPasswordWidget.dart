import 'dart:io';
import 'package:ecommerce_app_ui_kit/src/Controller/Login_Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';


class SetPasswordWidget extends StatefulWidget {
  @override
  _LoginScreen3State createState() => new _LoginScreen3State();
}

class _LoginScreen3State extends State<SetPasswordWidget> {
  TextEditingController password = new TextEditingController();
  TextEditingController confirmpassword = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _obscureTextLogin = true;

  FocusNode emailFocus = new FocusNode();
  FocusNode passwordFocus = new FocusNode();
  @override
  void initState() {
    super.initState();
  }

  void setPW() {
    final  LoginController controller = Get.find();
    controller.setPassword(
        id: controller.user.value.profileId,
        password: password.text,
        confirmPW: confirmpassword.text);
    emailFocus.unfocus();
    passwordFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        height: Get.height / 2,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(
              Radius.circular(5.0) //                 <--- border radius here
              ),
        ),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                new Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.only(left: 20.0, right: 10.0, top: 25.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.5),
                          width: 0.5,
                          style: BorderStyle.solid),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Expanded(
                        child: TextFormField(
                          obscureText: _obscureTextLogin,
                          controller: password,
                          validator: validatePassword,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextLogin
                                    ? FontAwesomeIcons.eyeSlash
                                    : FontAwesomeIcons.eye,
                                size: 15.0,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                new Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.only(left: 20.0, right: 10.0, top: 25.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.5),
                          width: 0.5,
                          style: BorderStyle.solid),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Expanded(
                        child: TextFormField(
                          obscureText: _obscureTextLogin,
                          controller: confirmpassword,
                          validator: confirmevalidatePassword,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextLogin
                                    ? FontAwesomeIcons.eyeSlash
                                    : FontAwesomeIcons.eye,
                                size: 15.0,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: 'Confirme Password',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 14.0,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: new FlatButton(
                        child: new Text(
                          "Set My Password",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.redAccent,
                            fontSize: 12.0,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        onPressed: () => {
                          if (_formKey.currentState.validate())
                            setPW()
                          else
                            SmartDialog.showToast("Invalid data ! ")
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                        "Note: You will see this window only one time after login via Social Media account that dosent exicst in our database after seating your password you will be able to login with your social media account or the eamil adress of your social media account and the password you just set "))
              ],
            )),
      ),
    );
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  String validateEmail(String text) {
    if (text.isEmpty /*|| !isEmail(text)*/) {
      return ("invalid_email");
    }
    return null;
  }

  String validatePassword(String text) {
    if (text.isEmpty) {
      return ("invalid password");
    } else if (text.length < 4) return ("Password is too shot");
    return null;
  }

  String confirmevalidatePassword(String text) {
    if (text != password.value.text) {
      return ("invalid password");
    } else if (text.length < 4) return ("Password is too shot");
    return null;
  }

  void showPlatformMsg(BuildContext context, String content,
      {String title = "Alert"}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (Platform.isAndroid) {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.white,
        duration: Duration(seconds: 5),
      ));
    } else if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("Okay"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop("Discard");
                })
          ],
        ),
      );
    }
  }
}
