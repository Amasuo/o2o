// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

import 'package:ecommerce_app_ui_kit/src/Controller/Category_Controller.dart';
import 'package:ecommerce_app_ui_kit/src/models/productFromJson.dart' as Product;

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.name,
    this.slug,
    this.available,
    this.image,
    this.parentcategory,
  });

  int id;
  String name;
  String slug;
  bool available;
  dynamic image;
  int parentcategory;
  bool selected;
  List<Product.Result> products =[];

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    available: json["available"],
    image: json["image"],
    parentcategory: json["parentcategory"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "available": available,
    "image": image,
    "parentcategory": parentcategory,
  };
}

class CategoriesList {
  static List<Result> _categoriesList= [];

  static List<Result> get categoriesList => _categoriesList;

  static selectById(int id) {
    _categoriesList.forEach((Result category) {
      category.selected = false;
      if (category.id == id) {
        category.selected = true;
      }
    });
  }
}

Future<void> loadCategoriesList() async{
  bool first= true;
  CategoryController controller = new CategoryController();
  await controller.getCategories();
  for (Result r in controller.categoryList) {
    if (first){
      r.selected = true;
    }
    else {
      r.selected = false;
    }
    for (Product.Result rr in Product.ProductsList.productsList) {
      if (rr.category == r.id)
        r.products.add(rr);
    }
    CategoriesList._categoriesList.add(r);
    first = false;
  }
}
