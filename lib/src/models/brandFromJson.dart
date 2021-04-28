// To parse this JSON data, do
//
//     final brand = brandFromJson(jsonString);

import 'dart:convert';

import 'package:ecommerce_app_ui_kit/src/Controller/Brand_Controller.dart';
import 'package:ecommerce_app_ui_kit/src/models/productFromJson.dart' as Product;

Brand brandFromJson(String str) => Brand.fromJson(json.decode(str));

String brandToJson(Brand data) => json.encode(data.toJson());

class Brand {
  Brand({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
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
    this.image,
    this.available,
  });

  int id;
  String name;
  String slug;
  dynamic image;
  bool available;
  bool selected;
  List<Product.Result> products =[];

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    image: json["image"],
    available: json["available"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "image": image,
    "available": available,
  };
}

class BrandsList {
  static List<Result> _brandsList= [];

  static List<Result> get brandsList => _brandsList;

  static selectById(int id) {
    _brandsList.forEach((Result category) {
      category.selected = false;
      if (category.id == id) {
        category.selected = true;
      }
    });
  }
}

Future<void> loadBrandsList() async{
  bool first= true;
  BrandController controller = new BrandController();
  await controller.getBrands();
  for (Result r in controller.brandList) {
    if (first)
      r.selected = true;
    else
      r.selected = false;
    for (Product.Result rr in Product.ProductsList.productsList) {
      if (rr.brand == r.id)
        r.products.add(rr);
    }
    BrandsList._brandsList.add(r);
    first = false;
  }
}