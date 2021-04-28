import 'package:ecommerce_app_ui_kit/config/search.dart';
import 'package:ecommerce_app_ui_kit/config/ui_icons.dart';
import 'package:ecommerce_app_ui_kit/src/models/categoryFromJson.dart' as Category;
import 'package:ecommerce_app_ui_kit/src/models/parentCategoryFromJson.dart' as ParentCategory;
import 'package:ecommerce_app_ui_kit/src/models/productFromJson.dart' as Product;
import 'package:ecommerce_app_ui_kit/src/models/route_argument.dart';
import 'package:ecommerce_app_ui_kit/src/screens/search/search_delegate.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/DrawerWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/MyNoticeVecAnimation.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart' hide Banner, showSearch;
import 'package:get/get.dart';

class CategoriesWidget extends StatefulWidget {
  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  ParentCategory.Result _parentCategory;

  @override
  void initState() {
    _parentCategory = ParentCategory.ParentCategoriesList.parentCategoriesList.first;
    ParentCategory.ParentCategoriesList.selectById(_parentCategory.id);
    super.initState();
  }

  AppBar searchAppBar() => AppBar(
    //automaticallyImplyLeading: false,
    // flu
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: InkWell(
        onTap: () =>
            showSearch(context: context, delegate: DefaultSearchDelegate()),
        child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 0, top: 0, right: 0),
            padding: EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).accentColor),
              // color: Color(0xffE4E2E8),
              borderRadius: BorderRadius.all(
                //圆角
                Radius.circular(60.0),
              ),
            ),
            child: Center(
                child: Container(
                  child: MyNoticeVecAnimation(
                      duration: const Duration(milliseconds: 2000),
                      messages: ["Search Stores", "Search Products"]),
                )))),

    actions: <Widget>[
      Container(
        width: 30,
        height: 30,
        margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
        child: GestureDetector(
          //borderRadius: BorderRadius.circular(300),
            onTap: () {
              // Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            },
            child: Icon(Icons.qr_code_rounded)),
      ),
    ],
  );

  void changeContent(ParentCategory.Result parentCategory) {
    setState(() {
      ParentCategory.ParentCategoriesList.selectById(parentCategory.id);
      _parentCategory = ParentCategory.ParentCategoriesList.parentCategoriesList.firstWhere((element) => element.id == parentCategory.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchAppBar(),
      body: Padding(
        padding: EdgeInsets.only(top: 5),
        child: Row(
          crossAxisAlignment:  CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: new BoxConstraints(
                  maxWidth: Get.width/3.3
              ),
              child:
              ListView(
                shrinkWrap: true,
                children: [
                  for(ParentCategory.Result parentCategory in ParentCategory.ParentCategoriesList.parentCategoriesList )
                    Container(
                      decoration: (parentCategory.selected) ? BoxDecoration(
                        color: Colors.white,
                      ): BoxDecoration(
                          color: Colors.grey[200]
                      ),
                      child:
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            changeContent(parentCategory);
                          }
                          );
                        },
                        child:
                        Center(
                          child:
                          Column(
                            mainAxisAlignment:MainAxisAlignment.center ,
                            children: [
                              Icon(UiIcons.box),
                              ListTile(
                                title: Text(
                                  parentCategory.name,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child:
              content(_parentCategory),
            ),
          ],
        ),
      ),
    );
  }


  Widget content(ParentCategory.Result parentCategory) {
    return ListView(
        children: [
          for (Category.Result category in parentCategory.children)
            ExpansionTile(
              title: Text(category.name),
              children: [
                Wrap(
                  direction: Axis.horizontal,
                  children: [
                    for (Product.Result product in category.products)
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/Product',
                              arguments: new RouteArgument(
                                  argumentsList: [product, Text('product')],
                                  id: product.id));
                        },
                        child: Padding(
                          padding: new EdgeInsets.fromLTRB(0, 0, 10, 20),
                          child:
                          Container(
                            width: Get.width/3.5,
                            height: Get.width/3.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: Get.width/4,
                                  alignment: Alignment.center,
                                  child: (product.image1 != null) ? Image.network(product.image1) : Image.asset('img/product.png'),
                                ),
                                Expanded(
                                  child: Text(
                                    product.name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ],
            ),
        ],
    );
  }

}
