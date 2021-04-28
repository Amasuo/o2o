import 'package:ecommerce_app_ui_kit/config/ui_icons.dart';
import 'package:ecommerce_app_ui_kit/src/models/brandFromJson.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/BrandIconWidget.dart';
import 'package:flutter/material.dart';

class BrandsIconsCarouselWidget extends StatefulWidget {
  List<Result> brandsList;
  Text heroTag;
  ValueChanged<String> onChanged;

  BrandsIconsCarouselWidget({Key key, this.brandsList, this.heroTag, this.onChanged}) : super(key: key);

  @override
  _BrandsIconsCarouselWidgetState createState() => _BrandsIconsCarouselWidgetState();
}

class _BrandsIconsCarouselWidgetState extends State<BrandsIconsCarouselWidget> {
//  BrandsList _brandsList = new BrandsList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor.withOpacity(1),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(0), topRight: Radius.circular(0)),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: BrandsList.brandsList.length,
                  itemBuilder: (context, index) {
                    double _marginLeft = 0;
                    (index == 0) ? _marginLeft = 12 : _marginLeft = 0;
                    return BrandIconWidget(
                        heroTag: widget.heroTag,
                        marginLeft: _marginLeft,
                        brand: BrandsList.brandsList.elementAt(index),
                        onPressed: (String id) {
                          setState(() {
                            BrandsList.selectById(int.parse(id));
                            widget.onChanged(id);
                          });
                        });
                  },
                  scrollDirection: Axis.horizontal,
                )),
          ),
          Container(
            width: 80,
            margin: EdgeInsets.only(left: 0),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(1),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0), topLeft: Radius.circular(0)),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/Brands');
              },
              icon: Icon(
                UiIcons.settings_2,
                size: 28,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
