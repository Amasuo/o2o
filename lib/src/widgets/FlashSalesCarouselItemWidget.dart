import 'package:ecommerce_app_ui_kit/src/models/productFromJson.dart';
import 'package:ecommerce_app_ui_kit/src/models/route_argument.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/AvailableProgressBarWidget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FlashSalesCarouselItemWidget extends StatelessWidget {
  Text heroTag;
  double marginLeft;
  Result product;

  FlashSalesCarouselItemWidget({
    Key key,
    this.heroTag,
    this.marginLeft,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/Product',
            arguments: new RouteArgument(
                id: product.id, argumentsList: [product, heroTag]));
      },
      child: Container(
        margin: EdgeInsets.only(left: this.marginLeft, right: 5),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Hero(
              tag: heroTag.data + product.id.toString(),
              child: Container(
                width: 120,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: (product.image1!= null) ? NetworkImage(product.image1) : AssetImage('img/product.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(0),
                        bottomRight: Radius.circular(7),
                        topLeft: Radius.circular(7)),
                    color: Theme.of(context).accentColor),
                alignment: AlignmentDirectional.topEnd,
                child: Text(
                  '${product.discountAmount} %',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Theme.of(context).primaryColor, fontSize: 8),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 80),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              width: 120,
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6),
                // boxShadow: [
                //   BoxShadow(
                //       color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                // ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    style: Theme.of(context)
                        .textTheme
                        .body2
                        .copyWith(fontSize: 10),
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                  Row(
                    children: <Widget>[
                      // The title of the product
                      Expanded(
                        child: Text(
                          '${product.soldCount} Sales',
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .copyWith(fontSize: 8),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                      ),
                      /*Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 12,
                      ),
                      Text(
                        product.rate.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .body2
                            .copyWith(fontSize: 10),
                      )*/
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  SizedBox(height: 3),
                  Text(
                    '${product.qty} Available',
                    style: Theme.of(context).textTheme.body1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AvailableProgressBarWidget(
                      available: product.qty.toDouble())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
