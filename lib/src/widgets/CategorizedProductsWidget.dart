import 'package:ecommerce_app_ui_kit/src/models/productFromJson.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/ProductGridItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategorizedProductsWidget extends StatelessWidget {
  const CategorizedProductsWidget({
    Key key,
    @required this.animationOpacity,
    @required List<Result> productsList,
  })  : _productsList = productsList,
        super(key: key);

  final Animation animationOpacity;
  final List<Result> _productsList;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationOpacity,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: new StaggeredGridView.countBuilder(
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 4,
          itemCount: _productsList.length,
          itemBuilder: (BuildContext context, int index) {
            Result product = _productsList.elementAt(index);
            return ProductGridItemWidget(
              product: product,
              heroTag: Text('categorized_products_grid'),
            );
          },
          // staggeredTileBuilder: (int index) => new StaggeredTile.count(2, index.isEven ? 4 : 2),
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
        ),
      ),
    );
  }
}
