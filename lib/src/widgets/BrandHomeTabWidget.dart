import 'package:ecommerce_app_ui_kit/config/ui_icons.dart';
import 'package:ecommerce_app_ui_kit/src/models/storeFromJson.dart' as Store;
import 'package:ecommerce_app_ui_kit/src/models/productFromJson.dart' as Product;
import 'package:ecommerce_app_ui_kit/src/widgets/FlashSalesCarouselWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/HomeSliderWidget.dart';
import 'package:flutter/material.dart';

class StoreHomeTabWidget extends StatefulWidget {
  Store.Result store;
  Product.ProductsList _productsList = new Product.ProductsList();

  StoreHomeTabWidget({this.store});

  @override
  _StoreHomeTabWidget createState() => _StoreHomeTabWidget();
}

class _StoreHomeTabWidget extends State<StoreHomeTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.flag,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              widget.store.name,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
        HomeSliderWidget(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.favorites,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Description',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: (widget.store.description != '') ? Text(
              widget.store.description
          ) : Text(
              'description'
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.trophy,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Featured Products',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
        FlashSalesCarouselWidget(
            heroTag: Text('brand_featured_products'),
            productsList: Product.ProductsList.flashSalesList),
      ],
    );
  }
}
