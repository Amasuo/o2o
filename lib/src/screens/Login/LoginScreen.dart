import 'dart:io';

import 'package:ecommerce_app_ui_kit/src/Controller/Login_Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen3State createState() => new _LoginScreen3State();
}

class _LoginScreen3State extends State<LoginScreen>
    with TickerProviderStateMixin {
  TextEditingController email = new TextEditingController();
  TextEditingController username = new TextEditingController();
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

  Widget loginPage() {
    return new Stack(
      children: [
        Container(
          child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(
                              top: 30, left: 80, right: 80, bottom: 10),
                          child: Image.asset("assets/png/B2S2C-red.png")),
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 10.0, top: 5.0),
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
                                obscureText: false,
                                controller: email,
                                textAlign: TextAlign.left,
                                validator: validateEmail,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'E-mail/Username',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 10.0, top: 25.0),
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
                                "Forgot Password?",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.redAccent,
                                  fontSize: 12.0,
                                ),
                                textAlign: TextAlign.end,
                              ),
                              onPressed: () => {},
                            ),
                          ),
                        ],
                      ),
                      Obx(() => renderLoginButton()),
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 20.0),
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            new Expanded(
                              child: new Container(
                                margin: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.25)),
                              ),
                            ),
                            Text(
                              "OR CONNECT WITH",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            new Expanded(
                              child: new Container(
                                margin: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.25)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 20.0),
                          child: SignInButton(
                            Buttons.Google,
                            onPressed: () {
                              LoginController.to.googlelogin(context);
                            },
                          )),
                      new Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 10.0),
                          child: SignInButton(
                            Buttons.Facebook,
                            onPressed: () {
                              LoginController.to.facebooklogin(context);
                            },
                          )),
                      new InkWell(
                          onTap: () => gotoSignup(),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                  left: 30.0, right: 30.0, top: 30.0),
                              child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'No Account?',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                          )),
                                      TextSpan(text: "  "),
                                      TextSpan(
                                        text: 'Register',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.redAccent),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center))),
                    ],
                  ))),
        ),
        Positioned(
          top: 30,
          left: 10,
          child: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Get.back(),
          ),
        )
      ],
    );
  }

  Widget signupPage() {
    return new Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
              padding:
                  EdgeInsets.only(top: 30, left: 80, right: 80, bottom: 10),
              child: Image.asset("assets/png/B2S2C-red.png")),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 20.0, right: 10.0, top: 5.0),
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
                    obscureText: false,
                    controller: email,
                    textAlign: TextAlign.left,
                    validator: validateEmail,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'E-mail',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 20.0, right: 10.0, top: 5.0),
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
                    obscureText: false,
                    controller: username,
                    textAlign: TextAlign.left,
                    validator: validateEmail,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 20.0, right: 10.0, top: 25.0),
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
            margin: const EdgeInsets.only(left: 20.0, right: 10.0, top: 25.0),
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
            height: 24.0,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: new FlatButton(
                  child: new Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  onPressed: () => gotoLogin(),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    color: Colors.redAccent,
                    onPressed: () => {
                      LoginController.to.signUpUser(
                          username.value.text,
                          password.value.text,
                          confirmpassword.value.text,
                          email.value.text)
                    },
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "SIGN UP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  loginLoading() => Padding(
      padding: EdgeInsets.all(0.0),
      child: LoadingBouncingGrid.square(
        inverted: true,
        size: 30,
        backgroundColor: Theme.of(context).accentColor,
      ));
  Widget renderLoginButton() {
    final LoginController controller = Get.find();
    switch (controller.status) {
      case Status.Authenticated:
        return Container();

      case Status.Authenticating:
        //return loginLoading();

      case Status.Uninitialized:
      case Status.Unauthenticated:
      default:
        return new Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
          alignment: Alignment.center,
          child: new FlatButton(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            color: Colors.redAccent,
            onPressed: () => {
              if (_formKey.currentState.validate()) {login()}
            },
            child: new Container(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 20.0,
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    child: Text(
                      "Sign in",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }

  gotoLogin() {
    //controller_0To1.forward(from: 0.0);
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  gotoSignup() {
    //controller_minus1To0.reverse(from: 0.0);
    _controller.animateToPage(
      1,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  void login() {
    final LoginController controller = Get.find();
    controller.signInUser(email.value.text, password.value.text);
    emailFocus.unfocus();
    passwordFocus.unfocus();
  }

  PageController _controller =
      new PageController(initialPage: 0, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: PageView(
            controller: _controller,
            physics: new BouncingScrollPhysics(),
            children: <Widget>[loginPage(), signupPage()],
            scrollDirection: Axis.horizontal,
          )),
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
