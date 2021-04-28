import 'package:ecommerce_app_ui_kit/src/models/product.dart';
import 'package:ecommerce_app_ui_kit/src/models/productFromJson.dart';
import 'package:ecommerce_app_ui_kit/src/models/route_argument.dart';
import 'package:flutter/material.dart';

class ProductGridItemWidget extends StatelessWidget {
  const ProductGridItemWidget({
    Key key,
    @required this.product,
    @required this.heroTag,
  }) : super(key: key);

  final Result product;
  final Text heroTag;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).pushNamed('/Product',
            arguments: new RouteArgument(
                argumentsList: [this.product, this.heroTag],
                id: this.product.id));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(6),
          // boxShadow: [
          //   BoxShadow(
          //       color: Theme.of(context).hintColor.withOpacity(0.10),
          //       offset: Offset(0, 4),
          //       blurRadius: 0.1)
          // ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: Text(this.heroTag.data + product.id.toString()),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: (product.image1 != null) ?Image.network(product.image1) : Image.asset('img/product.png'),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.fade,
                //softWrap: false,
                style: TextStyle(fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                product.getPrice(),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: <Widget>[
                  // The title of the product
                  Expanded(
                    child: Text(
                      '${product.soldCount} Sold',
                      style: TextStyle(fontSize: 10),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ),
                  /*Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 18,
                  ),
                  Text(
                    product.rate.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  )*/
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
