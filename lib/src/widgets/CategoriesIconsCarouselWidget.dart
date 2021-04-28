import 'package:ecommerce_app_ui_kit/config/ui_icons.dart';
import 'package:ecommerce_app_ui_kit/src/models/categoryFromJson.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/CategoryIconWidget.dart';
import 'package:flutter/material.dart';

class CategoriesIconsCarouselWidget extends StatefulWidget {
  List<Result> categoriesList;
  Text heroTag;
  ValueChanged<String> onChanged;

  CategoriesIconsCarouselWidget({Key key, this.categoriesList, this.heroTag, this.onChanged}) : super(key: key);

  @override
  _CategoriesIconsCarouselWidgetState createState() => _CategoriesIconsCarouselWidgetState();
}

class _CategoriesIconsCarouselWidgetState extends State<CategoriesIconsCarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(1),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(0), topRight: Radius.circular(0)),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/Categories');
              },
              icon: Icon(
                UiIcons.settings_2,
                size: 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(left: 0),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor.withOpacity(1),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0), topLeft: Radius.circular(0)),
                ),
                child: ListView.builder(
                  itemCount: CategoriesList.categoriesList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    double _marginLeft = 0;
                    (index == 0) ? _marginLeft = 12 : _marginLeft = 0;
                    return CategoryIconWidget(
                        heroTag: widget.heroTag,
                        marginLeft: _marginLeft,
                        category: CategoriesList.categoriesList.elementAt(index),
                        onPressed: (String id) {
                          setState(() {
                            CategoriesList.selectById(int.parse(id));
                            widget.onChanged(id);
                          });
                        });
                  },
                  scrollDirection: Axis.horizontal,
                )),
          ),
        ],
      ),
    );
  }
}
