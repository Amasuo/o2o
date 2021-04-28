// To parse this JSON data, do
//
//     final parentCategory = parentCategoryFromJson(jsonString);

import 'dart:convert';

import 'package:ecommerce_app_ui_kit/src/Controller/Category_Controller.dart';
import 'package:ecommerce_app_ui_kit/src/models/categoryFromJson.dart' as Category;

ParentCategory parentCategoryFromJson(String str) => ParentCategory.fromJson(json.decode(str));

String parentCategoryToJson(ParentCategory data) => json.encode(data.toJson());

class ParentCategory {
  ParentCategory({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory ParentCategory.fromJson(Map<String, dynamic> json) => ParentCategory(
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
  });

  int id;
  String name;
  String slug;
  bool available;
  bool selected;
  List<Category.Result> children =[];

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    available: json["available"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "available": available,
  };
}

class ParentCategoriesList {
  static List<Result> _parentCategoriesList= [];

  static List<Result> get parentCategoriesList => _parentCategoriesList;

  static selectById(int id) {
    _parentCategoriesList.forEach((Result parentCategory) {
      parentCategory.selected = false;
      if (parentCategory.id == id) {
        parentCategory.selected = true;
      }
    });
  }

}


Future<void> loadParentCategoriesList() async{
  bool first= true;
  CategoryController controller = new CategoryController();
  await controller.getParentCategories();
  for (Result r in controller.parentCategoryList) {
    if (first){
      r.selected = true;
    }
    else {
      r.selected = false;
    }
    for (Category.Result rr in Category.CategoriesList.categoriesList) {
      if (rr.parentcategory == r.id)
        r.children.add(rr);
    }
    ParentCategoriesList._parentCategoriesList.add(r);
    first = false;
  }
}