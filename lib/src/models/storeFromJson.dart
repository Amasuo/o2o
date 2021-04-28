// To parse this JSON data, do
//
//     final store = storeFromJson(jsonString);

import 'dart:convert';

import 'package:ecommerce_app_ui_kit/src/Controller/Store_Controller.dart';
import 'package:ecommerce_app_ui_kit/src/models/productFromJson.dart' as Product;


Store storeFromJson(String str) => Store.fromJson(json.decode(str));

String storeToJson(Store data) => json.encode(data.toJson());

class Store {
  Store({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
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
    this.address,
    this.country,
    this.state,
    this.street,
    this.zipCode,
    this.phone,
    this.icon,
    this.image,
    this.raiting,
    this.likeCount,
    this.created,
    this.updated,
    this.featured,
    this.popular,
    this.ordersCount,
    this.description,
  });

  int id;
  String name;
  String address;
  String country;
  String state;
  String street;
  int zipCode;
  String phone;
  dynamic icon;
  dynamic image;
  String raiting;
  int likeCount;
  DateTime created;
  DateTime updated;
  bool featured;
  bool popular;
  int ordersCount;
  String description;
  bool selected;
  List<Product.Result> products =[];

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    country: json["country"],
    state: json["state"],
    street: json["street"],
    zipCode: json["zip_code"],
    phone: json["phone"],
    icon: json["icon"],
    image: json["image"],
    raiting: json["raiting"],
    likeCount: json["like_count"],
    created: DateTime.parse(json["created"]),
    updated: DateTime.parse(json["updated"]),
    featured: json["featured"],
    popular: json["popular"],
    ordersCount: json["orders_count"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "country": country,
    "state": state,
    "street": street,
    "zip_code": zipCode,
    "phone": phone,
    "icon": icon,
    "image": image,
    "raiting": raiting,
    "like_count": likeCount,
    "created": created.toIso8601String(),
    "updated": updated.toIso8601String(),
    "featured": featured,
    "popular": popular,
    "orders_count": ordersCount,
    "description": description,
  };
}

class StoresList {
  static List<Result> _storesList= [];

  static List<Result> get storesList => _storesList;

}

Future<void> loadStoresList() async{
  bool first= true;
  StoreController controller = new StoreController();
  await controller.getStores();
  for (Result r in controller.storeList) {
    if (first){
      r.selected = true;
    }
    else {
      r.selected = false;
    }
    for (Product.Result rr in Product.ProductsList.productsList) {
      if (rr.store == r.id)
        r.products.add(rr);
    }
    StoresList._storesList.add(r);
    first = false;
  }
}