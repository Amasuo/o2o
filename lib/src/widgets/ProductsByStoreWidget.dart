import 'package:ecommerce_app_ui_kit/config/ui_icons.dart';
import 'package:ecommerce_app_ui_kit/src/models/storeFromJson.dart' as Store;
import 'package:ecommerce_app_ui_kit/src/models/productFromJson.dart' as Product;
import 'package:ecommerce_app_ui_kit/src/widgets/FavoriteListItemWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/ProductGridItemWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductsByStoreWidget extends StatefulWidget {
  Store.Result store;

  ProductsByStoreWidget({Key key, this.store}) : super(key: key);

  @override
  _ProductsByStoreWidget createState() => _ProductsByStoreWidget();
}

class _ProductsByStoreWidget extends State<ProductsByStoreWidget> {
  String layout = 'grid';
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SearchBarWidget(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.box,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              '${widget.store.name} Products',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: Theme.of(context).textTheme.display1,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    setState(() {
                      this.layout = 'list';
                    });
                  },
                  icon: Icon(
                    Icons.format_list_bulleted,
                    color: this.layout == 'list' ? Theme.of(context).accentColor : Theme.of(context).focusColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      this.layout = 'grid';
                    });
                  },
                  icon: Icon(
                    Icons.apps,
                    color: this.layout == 'grid' ? Theme.of(context).accentColor : Theme.of(context).focusColor,
                  ),
                )
              ],
            ),
          ),
        ),
        Offstage(
          offstage: this.layout != 'list',
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            itemCount: widget.store.products.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              // TODO replace with products list item
              return FavoriteListItemWidget(
                heroTag: 'products_by_category_list',
                product: widget.store.products.elementAt(index),
                onDismissed: () {
                  setState(() {
                    widget.store.products.removeAt(index);
                  });
                },
              );
            },
          ),
        ),
        Offstage(
          offstage: this.layout != 'grid',
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: new StaggeredGridView.countBuilder(
              primary: false,
              shrinkWrap: true,
              crossAxisCount: 4,
              itemCount: widget.store.products.length,
              itemBuilder: (BuildContext context, int index) {
                Product.Result product = widget.store.products.elementAt(index);
                return ProductGridItemWidget(
                  product: product,
                  heroTag: Text('products_by_category_grid'),
                );
              },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
            ),
          ),
        ),
      ],
    );
  }
}
