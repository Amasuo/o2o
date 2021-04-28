import 'package:ecommerce_app_ui_kit/config/search.dart';
import 'package:ecommerce_app_ui_kit/config/ui_icons.dart';
import 'package:ecommerce_app_ui_kit/src/models/categoryFromJson.dart' as Category;
import 'package:ecommerce_app_ui_kit/src/models/parentCategoryFromJson.dart' as ParentCategory;
import 'package:ecommerce_app_ui_kit/src/models/route_argument.dart';
import 'package:ecommerce_app_ui_kit/src/screens/search/search_delegate.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/DrawerWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/MyNoticeVecAnimation.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart' hide Banner, showSearch;

class CategoriesWidget extends StatefulWidget {
  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // drawer: DrawerWidget(),
      appBar: searchAppBar(),
      //  AppBar(
      //   automaticallyImplyLeading: false,
      //   // leading: new IconButton(
      //   //   icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
      //   //   onPressed: () => Navigator.of(context).pop(),
      //   // ),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Text(
      //     'Categorie',
      //     style: Theme.of(context).textTheme.headline4,
      //   ),
      //   actions: <Widget>[
      //     new ShoppingCartButtonWidget(
      //         iconColor: Theme.of(context).hintColor,
      //         labelColor: Theme.of(context).accentColor),
      //     Container(
      //         width: 30,
      //         height: 30,
      //         margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
      //         child: InkWell(
      //           borderRadius: BorderRadius.circular(300),
      //           onTap: () {
      //             Navigator.of(context).pushNamed('/Tabs', arguments: 1);
      //           },
      //           child: CircleAvatar(
      //             backgroundImage: AssetImage('img/user2.jpg'),
      //           ),
      //         )),
      //   ],
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Wrap(
          runSpacing: 20,
          children: <Widget>[
            // SearchBarWidget(),
            Wrap(
              runSpacing: 30,
              children: List.generate(ParentCategory.ParentCategoriesList.parentCategoriesList.length, (index) {
                ParentCategory.Result parentCategory = ParentCategory.ParentCategoriesList.parentCategoriesList.elementAt(index);
                return index.isEven
                    ? buildEvenCategory(context, parentCategory)
                    : buildOddCategory(context, parentCategory);
              }),
            ),
          ],
        ),
//        child: buildOddCategory(context),
      ),
    );
  }

  Widget buildEvenCategory(BuildContext context, ParentCategory.Result parentCategory) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 120,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.10),
                          offset: Offset(0, 4),
                          blurRadius: 10)
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Theme.of(context).accentColor,
                          Theme.of(context).accentColor.withOpacity(0.2),
                        ])),
                child: Column(
                  children: <Widget>[
                    Hero(
                      tag: Text(parentCategory.id.toString()),
                      child: Icon(
                        UiIcons.box,
                        color: Theme.of(context).primaryColor,
                        size: 40,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      parentCategory.name,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              ),
              Positioned(
                right: -40,
                bottom: -60,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              ),
              Positioned(
                left: -30,
                top: -60,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(0.10),
                    offset: Offset(0, 4),
                    blurRadius: 10)
              ],
            ),
            constraints: BoxConstraints(minHeight: 120),
            child: Wrap(
              runAlignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 5,
              children: List.generate(parentCategory.children.length, (index) {
                Category.Result subCategory = parentCategory.children[index];
                return Material(
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/Category',
                          arguments: RouteArgument(
                              id: index, argumentsList: [parentCategory]));
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color:
                                Theme.of(context).hintColor.withOpacity(0.2)),
                      ),
                      child: Text(
                        subCategory.name,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        )
      ],
    );
  }

  Widget buildOddCategory(BuildContext context, ParentCategory.Result parentCategory) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(0.10),
                    offset: Offset(0, 4),
                    blurRadius: 10)
              ],
            ),
            constraints: BoxConstraints(minHeight: 120),
            child: Wrap(
              runAlignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 5,
              children: List.generate(parentCategory.children.length, (index) {
                Category.Result subCategory = parentCategory.children[index];
                return Material(
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/Category',
                          arguments: RouteArgument(
                              id: index, argumentsList: [parentCategory]));
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color:
                                Theme.of(context).hintColor.withOpacity(0.2)),
                      ),
                      child: Text(
                        subCategory.name,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        SizedBox(
          width: 120,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.10),
                          offset: Offset(0, 4),
                          blurRadius: 10)
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Theme.of(context).accentColor,
                          Theme.of(context).accentColor.withOpacity(0.2),
                        ])),
                child: Column(
                  children: <Widget>[
                    Hero(
                      tag: Text(parentCategory.id.toString()),
                      child: Icon(
                        UiIcons.box,
                        color: Theme.of(context).primaryColor,
                        size: 40,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      parentCategory.name,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              ),
              Positioned(
                right: -40,
                bottom: -60,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              ),
              Positioned(
                left: -30,
                top: -60,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
