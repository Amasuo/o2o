import 'dart:convert';
import 'package:ecommerce_app_ui_kit/src/models/brandFromJson.dart';
import 'package:ecommerce_app_ui_kit/src/models/categoryFromJson.dart';
import 'package:ecommerce_app_ui_kit/src/models/parentCategoryFromJson.dart';
import 'package:ecommerce_app_ui_kit/src/models/productFromJson.dart';
import 'package:ecommerce_app_ui_kit/src/models/storeFromJson.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();

  //----------------------------------------------Products----------------------------------------------------------
  static Future<Product> getProducts() async{
    String url = "https://siyoumarket.com/api/products";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<Product> getProductsByCategory(String category) async{
    String url = "https://siyoumarket.com/api/products?category=$category";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<Product> getProductsByStore(String store) async{
    String url = "https://siyoumarket.com/api/products?store=$store";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<Product> getDiscountedProducts() async{
    String url = "https://siyoumarket.com/api/products/discounted";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      return null;
    }
  }



//----------------------------------------------Categories----------------------------------------------------------
    static Future<Category> getCategories() async{
    String url = "https://siyoumarket.com/api/categories";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return categoryFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<ParentCategory> getParentCategories() async {
    String url = "https://siyoumarket.com/api/parentcategories";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return parentCategoryFromJson(jsonString);
    } else {
      return null;
    }
  }



//----------------------------------------------Stores----------------------------------------------------------
  static Future<Store> getStores() async{
    String url = "https://siyoumarket.com/api/stores";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return storeFromJson(jsonString);
    } else {
      return null;
    }
  }



//----------------------------------------------Brands----------------------------------------------------------
  static Future<Brand> getBrands() async{
    String url = "https://siyoumarket.com/api/brands";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return brandFromJson(jsonString);
    } else {
      return null;
    }
  }


}