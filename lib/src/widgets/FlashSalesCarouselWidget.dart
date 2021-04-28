import 'package:ecommerce_app_ui_kit/src/models/productFromJson.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/FlashSalesCarouselItemWidget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FlashSalesCarouselWidget extends StatelessWidget {
  List<Result> productsList;
  Text heroTag;

  FlashSalesCarouselWidget({
    Key key,
    this.productsList,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 165,
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(6),
        //     color: Theme.of(context).primaryColor),
        margin: EdgeInsets.only(
          top: 5,
        ),
        //padding:EdgeInsets.all(10) ,

        child: ListView.builder(
          itemCount: productsList.length,
          itemBuilder: (context, index) {
            double _marginLeft = 0;
            (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
            return FlashSalesCarouselItemWidget(
              heroTag: this.heroTag,
              marginLeft: _marginLeft,
              product: productsList.elementAt(index),
            );
          },
          scrollDirection: Axis.horizontal,
        ));
  }
}
