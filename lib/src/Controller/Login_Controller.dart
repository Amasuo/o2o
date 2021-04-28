import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_app_ui_kit/config/utils.dart';
import "package:ecommerce_app_ui_kit/src/Services/NetworkApi's.dart";
import 'package:ecommerce_app_ui_kit/src/models/User.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/SetPasswordWidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:image_picker/image_picker.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class LoginController extends GetxController {
  Rx<Status> _status = Status.Uninitialized.obs;
  Rx<User> user = User().obs;
  RxBool loading = false.obs;
  RxBool error = false.obs;
  RxBool islogedin = false.obs;
  static final ApiProvider api = ApiProvider();
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  static final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
    "796432126586-8425ekk076u9fv4s3cl9tfmeq9g8cok0.apps.googleusercontent.com",
    scopes: <String>[
      'email',
    ],
  );
  static LoginController get to => Get.find();

  Status get status => _status.value;
  @override
  void onInit() {
    super.onInit();
    userSignedIn();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> signUpUser(String userName, String password,
      String confirmpassword, String email) async {
    try {
      SmartDialog.showLoading();
      await api.signUpUser(userName, password, confirmpassword, email);
      SmartDialog.dismiss();

      Get.back();
    } catch (e) {
      SmartDialog.dismiss();
      showToast(
        "$e",
        duration: Duration(seconds: 2),
        position: ToastPosition.bottom,
        radius: 3.0,
      );
    }
  }

  Future<bool> userSignedIn() async {
    _status.value = Status.Authenticating;

    try {
      final String refresh = await getUserRefrechToken();
      final bool isfacebooklogin = await getisfacebooklogin() ?? false;
      final bool isgooglelogin = await getisfacebooklogin() ?? false;

      if (isfacebooklogin || isgooglelogin) {
        String localuser = await getUserInfo();
        user.value = User.fromJson(json.decode(localuser));
        _status.value = Status.Authenticated;
        islogedin.value = true;
      } else {
        final res = await api.refreshUser(refresh);

        if (res["access"] != null) {
          await saveUserToken(res["access"]);
          String localuser = await getUserInfo();
          user.value = User.fromJson(json.decode(localuser));
          _status.value = Status.Authenticated;
          islogedin.value = true;
          print(islogedin.value);
          return true;
        } else
          throw "${res["detail"]}";
      }
    } catch (e) {
      print("User Signed in error " + e.toString());
      logout();

      return false;
    }
  }

  Future<Map<String, dynamic>> signInUser(
      String username, String password) async {
    try {
      _status.value = Status.Authenticating;

      final data = await api.signInUser(username, password);

      var s = json.encode(data);

      if (data["refresh"] != null) {
        final user = User.fromJson(data);
        await saveUserInfo(s);
        await saveUserToken(data["access"]);
        await saveUserRefrechToken(data["refresh"]);

        this.user.value = user;
        _status.value = Status.Authenticated;
        islogedin.value = true;
        Get.back();

        return {
          "status": true,
        };
      } else {
        if (data["msg"] == "1")
          throw "Email or Password are empty !";
        else if (data["msg"] == "2")
          throw "Email & Password does not match any user";
        else
          throw "Internal server error, Please come back later";
      }
    } catch (e) {
      _status.value = Status.Unauthenticated;

      if (e is DioError) {
        final DioError error = e;
        SmartDialog.showToast("Server Error");
        return {"status": false, "error": error.message};
      } else {
        SmartDialog.showToast(
            "No active account found with the given credentials",
            time: Duration(
              seconds: 3,
            ),
            alignment: Alignment.bottomCenter);
        return {"status": false, "error": e.toString()};
      }
    }
  }

  Future<void> setPassword(
      {@required int id,
        @required String password,
        @required String confirmPW}) async {
    try {
      SmartDialog.showLoading();
      final data = await api.setNewUserPassword(
          id: id, password: password, confirmPW: confirmPW);
      if (data["refresh_token"] != null) {
        await saveUserToken(data["access_token"]);
        await saveUserRefrechToken(data["refresh_token"]);
        SmartDialog.dismiss();
        Get.back(result: true);
      } else
        throw ("Opps Somting Went Wrong !");
    } catch (e) {
      print(e);
      Get.back(result: false);
      SmartDialog.dismiss();
      SmartDialog.showToast(e.toString());
    }
  }

  Future<void> uploadPIC() async {
    File image;
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        image = File(pickedFile.path);
        SmartDialog.showLoading();
        final data =
        await api.updateProfilePic(image: image, id: user.value.profileId);
        SmartDialog.dismiss();
        this.user.update((user) {
          user.picUrl = data["photo"];
        });
      } else
        throw ("No file Picked");
    } catch (e) {
      SmartDialog.dismiss();
      SmartDialog.showToast(e.toString());
    }
  }

  Future<Null> facebooklogin(BuildContext context) async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;

        SmartDialog.showLoading();
        _status.value = Status.Authenticating;
        try {
          print(accessToken.token);
          final data = await api.facebookignInUser(accessToken.token);
          await saveUserToken(data["access_token"]);
          if (data['psw']) {
            final User tempuser = User(
                profileId: data["profile_id"],
                username: data["user"]["username"],
                email: data["user"]["username"],
                firstName: data["user"]["first_name"],
                lastName: data["user"]["last_name"],
                picUrl: "");
            var s = json.encode(tempuser.toJson());
            await saveUserInfo(s);
            this.user.value = tempuser;
            _status.value = Status.Authenticated;
            islogedin.value = true;
            SmartDialog.dismiss();
            await isfacebooklogin();
            Get.back();
          } else {
            final User tempuser = User(
                profileId: data["profile_id"],
                username: data["user"]["username"],
                email: data["user"]["username"],
                firstName: data["user"]["first_name"],
                lastName: data["user"]["last_name"],
                picUrl: "");
            this.user.value = tempuser;
            SmartDialog.dismiss();
            final resutl = await showDialog<bool>(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return Scaffold(
                      backgroundColor: Colors.transparent,
                      body: SetPasswordWidget());
                });
            if (resutl) {
              var s = json.encode(tempuser.toJson());
              await saveUserInfo(s);

              _status.value = Status.Authenticated;
              islogedin.value = true;
              Get.back();
            } else {
              _status.value = Status.Unauthenticated;
            }
          }
        } catch (e) {
          print(e);
          _status.value = Status.Unauthenticated;
          SmartDialog.dismiss();
          SmartDialog.showToast(e.toString());
          googleSignIn.signOut();
        }

        break;
      case FacebookLoginStatus.cancelledByUser:
        SmartDialog.showToast('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        SmartDialog.showToast(
            'Something went wrong with the login process.\n'
                'Here\'s the error Facebook gave us: ${result.errorMessage}',
            time: Duration(seconds: 5));
        print(result.errorMessage);
        break;
    }
  }

  Future<void> googlelogin(BuildContext context) async {
    googleSignIn.signIn().then((result) {
      print(result.toString());
      result.authentication.then((googleKey) async {
        SmartDialog.showLoading();
        _status.value = Status.Authenticating;
        print(googleKey.accessToken);
        try {
          final data = await api.googlesignInUser(googleKey.accessToken);
          print(data);
          await saveUserToken(data["access_token"]);
          if (data['psw']) {
            final User tempuser = User(
                profileId: data["profile_id"],
                username: result.displayName,
                email: result.email,
                firstName: result.displayName,
                lastName: "",
                picUrl: result.photoUrl);
            var s = json.encode(tempuser.toJson());
            await saveUserInfo(s);
            this.user.value = tempuser;
            _status.value = Status.Authenticated;
            islogedin.value = true;
            SmartDialog.dismiss();
            await isgooglelogin();
            Get.back();
          } else {
            final User tempuser = User(
                profileId: data["profile_id"],
                username: result.displayName,
                email: result.email,
                firstName: result.displayName,
                lastName: "",
                picUrl: result.photoUrl);
            this.user.value = tempuser;
            SmartDialog.dismiss();
            final resutl = await showDialog<bool>(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return Scaffold(
                      backgroundColor: Colors.transparent,
                      body: SetPasswordWidget());
                });
            if (resutl) {
              var s = json.encode(tempuser.toJson());
              await saveUserInfo(s);

              _status.value = Status.Authenticated;
              islogedin.value = true;
              Get.back();
            } else {
              _status.value = Status.Unauthenticated;
            }
          }
        } catch (e) {
          print(e);
          _status.value = Status.Unauthenticated;
          SmartDialog.dismiss();
          SmartDialog.showToast(e.toString());
          googleSignIn.signOut();
        }
      }).catchError((err) {
        _status.value = Status.Unauthenticated;
        SmartDialog.dismiss();
        SmartDialog.showToast(err);
      });
    }).catchError((err) {
      print(err);
      _status.value = Status.Unauthenticated;
      SmartDialog.dismiss();
      SmartDialog.showToast(err.toString());
    });
  }

  Future<void> logout() async {
    googleSignIn.signOut();
    facebookSignIn.logOut();
    await clearPref();
    _status.value = Status.Uninitialized;
    islogedin.value = false;
  }
}
