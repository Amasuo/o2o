import 'dart:convert';

import 'package:ecommerce_app_ui_kit/src/Controller/Product_Controller.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
    this.barcode,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.shortDescription,
    this.description,
    this.price,
    this.discountAmount,
    this.tax,
    this.qty,
    this.warnQty,
    this.available,
    this.promoted,
    this.category,
    this.brand,
    this.store,
    this.created,
    this.updated,
    this.soldCount,
  });

  int id;
  String name;
  String slug;
  String barcode;
  String image1;
  String image2;
  String image3;
  String image4;
  String image5;
  String shortDescription;
  String description;
  String price;
  String discountAmount;
  String tax;
  int qty;
  int warnQty;
  bool available;
  bool promoted;
  int category;
  int brand;
  int store;
  DateTime created;
  DateTime updated;
  int soldCount;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    barcode: json["barcode"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    image4: json["image4"],
    image5: json["image5"],
    shortDescription: json["short_description"],
    description: json["description"],
    price: json["price"],
    discountAmount: json["discount_amount"],
    tax: json["tax"],
    qty: json["qty"],
    warnQty: json["warn_qty"],
    available: json["available"],
    promoted: json["promoted"],
    category: json["category"],
    brand: json["brand"],
    store: json["store"],
    created: DateTime.parse(json["created"]),
    updated: DateTime.parse(json["updated"]),
    soldCount: json["sold_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "barcode": barcode,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "image4": image4,
    "image5": image5,
    "short_description": shortDescription,
    "description": description,
    "price": price,
    "discount_amount": discountAmount,
    "tax": tax,
    "qty": qty,
    "warn_qty": warnQty,
    "available": available,
    "promoted": promoted,
    "category": category,
    "brand": brand,
    "store": store,
    "created": created.toIso8601String(),
    "updated": updated.toIso8601String(),
    "sold_count": soldCount,
  };

  String getPrice({String myPrice}) {
    if (myPrice != null) {
      return '\$${myPrice}';
    }
    return '\$${this.price}';
  }

}

class ProductsList {

  static List<Result> _productsList= [];
  static List<Result> _flashSalesList= [];
  static List<Result> _favoritesList=[];
  static List<Result> _cartList=[];

  static List<Result> get productsList => _productsList;
  static List<Result> get flashSalesList => _flashSalesList;
  static List<Result> get favoritesList => _favoritesList;
  static List<Result> get cartList => _cartList;

  static void addProductFavorite(Result p) async {
    _favoritesList.add(p);
  }

  static void deleteProductFavorite(Result p) async {
    _favoritesList.removeWhere((element) => element.name == p.name);
  }

  static void addProductCart(Result p) {
    _cartList.add(p);
  }

  static void deleteProductCart(Result p) async {
    _cartList.removeWhere((element) => element.name == p.name);
  }

}

Future<void> loadProductsList() async{
  ProductController controller = new ProductController();
  await controller.getProducts();
  for (Result r in controller.productList) {
    ProductsList._productsList.add(r);
  }
}

Future<void> loadFlashSalesList() async {
  ProductController controller = new ProductController();
  await controller.getDiscountedProducts();
  for (Result r in controller.productDiscountedList) {
    ProductsList._flashSalesList.add(r);
  }
}