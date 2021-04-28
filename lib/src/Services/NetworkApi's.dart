import 'dart:io';

import 'package:ecommerce_app_ui_kit/config/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiProvider {
  // API base config
  static final String baseUrl = "https://siyou.tn/s2c/o2o/";
  static final String onlinebaseUrl = "https://siyoumarket.com/";
  static final BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 15000,
      receiveTimeout: 15000,
      method: 'GET',
      contentType: Headers.jsonContentType);
  static final BaseOptions onlineoptions = BaseOptions(
      baseUrl: onlinebaseUrl,
      connectTimeout: 15000,
      receiveTimeout: 15000,
      method: 'GET',
      contentType: Headers.jsonContentType);
  final Dio dio = new Dio(options);
  final Dio onlinedio = new Dio(onlineoptions);

  /*
  * User Login API
  */
  Future<Map<String, dynamic>> signInUser(
      String username, String password) async {
    Map data = {'username': username.toLowerCase(), 'password': password};
    try {
      onlinedio.interceptors.add(PrettyDioLogger());
      final res = await onlinedio.request("/social_log/login/",
          options: Options(method: "POST"), data: data);

      return res.data;
    } catch (e) {
      print(e);
      return throw e;
    }
  }

  Future<Map<String, dynamic>> updateProfilePic(
      {@required File image, @required int id}) async {
    final token = await getUserToken();
    print(token);
    try {
      FormData formData = FormData.fromMap({
        "access_token": token,
        "file": image != null ? await MultipartFile.fromFile(image.path) : "",
        "pk": id
      });
      onlinedio.interceptors.add(PrettyDioLogger());
      final res = await onlinedio.put("/social_log/upload/pic", data: formData);
      print(res.data);
      return res.data;
    } catch (e) {
      print(e);
      return throw e;
    }
  }

  Future<Map<String, dynamic>> setNewUserPassword(
      {@required int id,
      @required String password,
      @required String confirmPW}) async {
    final token = await getUserToken();
    final Map data = {
      'access_token': token,
      'pk': id,
      'password': password,
      'password2': confirmPW
    };
    try {
      onlinedio.interceptors.add(PrettyDioLogger());
      final res = await onlinedio.post("api/Set_password/", data: data);

      return res.data;
    } catch (e) {
      print(e);
      return throw e;
    }
  }

  Future<Map<String, dynamic>> googlesignInUser(String token) async {
    final Map data = {'access_token': token};
    try {
      onlinedio.interceptors.add(PrettyDioLogger());
      final res = await onlinedio.post("api/social/google-oauth2/", data: data);

      return res.data;
    } catch (e) {
      print(e);
      return throw e;
    }
  }

  Future<Map<String, dynamic>> facebookignInUser(String token) async {
    final Map data = {'access_token': token};
    try {
      onlinedio.interceptors.add(PrettyDioLogger());
      final res = await onlinedio.post("api/social/facebook/", data: data);

      return res.data;
    } catch (e) {
      print(e);
      return throw e;
    }
  }

  Future<Map<String, dynamic>> signUpUser(String username, String password,
      String confirmpassword, String email) async {
    Map data = {
      'username': username.toLowerCase(),
      'password': password,
      'password2': confirmpassword,
      'first_name': "",
      'last_name': "",
      'email': email,
      'address': "",
      'country': "",
      'city': "",
      'street': "",
      'zip_code': "2000",
      'phone': "",
      'date_of_birth': "2000-01-01"
    };
    try {
      onlinedio.interceptors.add(PrettyDioLogger());
      final res = await onlinedio.request("/social_log/signup/",
          options: Options(method: "POST"), data: data);

      return res.data;
    } catch (e) {
      print(e);
      return throw e;
    }
  }

  Future<Map<String, dynamic>> refreshUser(String refresh) async {
    Map data = {"refresh": refresh};
    try {
      final res = await onlinedio.request("social_log/login/refresh/",
          options: Options(method: "POST"), data: data);

      return res.data;
    } catch (e) {
      print(e);
      return throw e;
    }
  }

  Future<Map<String, dynamic>> getOrderList(int profileID, int page) async {
    try {
      final res = await onlinedio.request("/api/s2corder/List",
          queryParameters: {"page": page ?? 1, "profile": profileID});

      return res.data;
    } catch (e) {
      print(e);
      return throw e;
    }
  }

  Future<Map<String, dynamic>> makeO2OOrder(order) async {
    try {
      final res = await dio.post("/orders/create",
          options: Options(method: "POST"), data: order);
      print(res.data);

      return res.data;
    } catch (e) {
      print(e);
      return throw e;
    }
  }

  Future<Map<String, dynamic>> saveOrderToOnline(data) async {
    final token = await getUserToken();
    final Map map = {'access_token': token, ...data};
    try {
      onlinedio.interceptors.add(PrettyDioLogger());
      final res = await onlinedio.request("api/s2corder/",
          options: Options(method: "POST"), data: map);

      return res.data;
    } catch (e) {
      print(e);
      return throw e;
    }
  }

  Future<Map<String, dynamic>> getChainList(
      {@required int page,
      String chain,
      String keyword,
      String supplier,
      String category}) async {
    try {
      dio.interceptors.add(PrettyDioLogger());
      final res = await dio.request("chains",
          queryParameters: {"page": page, "keyWord": keyword});

      return res.data;
    } catch (e) {
      print(e);
      return throw e;
    }
  }

  Future<Map<String, dynamic>> getChainAds({@required int chain}) async {
    try {
      dio.interceptors.add(PrettyDioLogger());
      final res =
          await dio.request("/ads", queryParameters: {"chain_id": chain});

      return res.data;
    } catch (e) {
      print(e);
      return throw e;
    }
  }

  Future<Map<String, dynamic>> getChainbycode(
      {@required String chaincode}) async {
    try {
      final res = await dio.request("/chains/code", queryParameters: {
        "chain_code": chaincode,
      });
      print(res.data);

      return res.data;
    } catch (e) {
      print(e);
      return throw e;
    }
  }

  Future<Map<String, dynamic>> getChainCategory(
      {/*@required int page,*/
      int chain,
      String keyword,
      String supplier,
      String category}) async {
    //String shopChain = "";

    try {
      final res = await dio.request("categories", queryParameters: {
        "chain_id": chain,
        // "barcode": keyword ?? "",
        // "category_id": category,
        // "page": page
      });

      return res.data;
    } catch (e) {
      print(e);
      return throw e;
    }
  }

  Future<Map<String, dynamic>> getChainProductsItems(
      {@required int page,
      int chain,
      String keyword,
      String supplier,
      String barcode,
      int category}) async {
    //String shopChain = "";

    try {
      final res = await dio.request("products", queryParameters: {
        "chain_id": chain,
        "barcode": barcode ?? "",
        "keyword": keyword,
        "category_id": category,
        // "page": page
      });

      return res.data;
    } catch (e) {
      print(e);
      return throw e;
    }
  }
}
