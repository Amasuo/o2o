import 'package:ecommerce_app_ui_kit/config/ui_icons.dart';
import 'package:ecommerce_app_ui_kit/config/utlis.dart';
import 'package:ecommerce_app_ui_kit/src/models/brand.dart';
import 'package:ecommerce_app_ui_kit/src/models/brandFromJson.dart' as Brand;
import 'package:ecommerce_app_ui_kit/src/models/categoryFromJson.dart' as Category;
import 'package:ecommerce_app_ui_kit/src/models/productFromJson.dart' as Product;
import 'package:ecommerce_app_ui_kit/src/models/storeFromJson.dart' as Store;
import 'package:ecommerce_app_ui_kit/src/screens/Services.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/BrandsIconsCarouselWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/CategoriesIconsCarouselWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/CategorizedProductsWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/FlashSalesCarouselWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/FlashSalesWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/HomeSliderWidget.dart';
import 'package:ecommerce_app_ui_kit/src/widgets/Siyou_Location_Widget.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'homeContentByCategory.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with SingleTickerProviderStateMixin {
  List<Product.Result> _productsOfCategoryList;
  List<Product.Result> _productsOfStoreList;
  List<Product.Result> _productsOfBrandList;
  //CategoriesList _categoriesList = new CategoriesList();
  Brand.BrandsList _brandsList = new Brand.BrandsList();
  Store.StoresList _storesList = new Store.StoresList();
  Product.ProductsList _productsList = new Product.ProductsList();
  List<Category.Result> _list = List<Category.Result>();
  Animation animationOpacity;
  AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    CurvedAnimation curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animationOpacity = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });

    animationController.forward();

    _productsOfCategoryList = Category.CategoriesList.categoriesList.firstWhere((category) {
      return category.selected;
    }).products;

    _productsOfBrandList = Brand.BrandsList.brandsList.firstWhere((brand) {
      return brand.selected;
    }).products;

    _productsOfStoreList = Store.StoresList.storesList.firstWhere((store) {
      return store.selected;
    }).products;
    super.initState();
    _list = Category.CategoriesList.categoriesList;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: _list.length + 1,
      child: Column(
        children: [
          tabBarIndicator(),
          Flexible(
            //flex: 10,
            child: TabBarView(
              children: [
                buildBody(),
                //for (int i = 0; i < _list.length; i++) Container()
                for (int i = 0; i < _list.length; i++) Content(i,_list[i].products),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget tabBarIndicator() => SizedBox(
      height: 30,
      child: Row(
        children: [
          Flexible(
            child: TabBar(
              indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
              indicatorWeight: 2.2,
              isScrollable: true,
              unselectedLabelStyle: TextStyle(color: Colors.black),
              tabs: [
                Text(
                  "Hot",
                  style: TextStyle(),
                ),
                for (var c in _list)
                  Text(
                    c.name,
                    style: TextStyle(),
                  )
              ],
            ),
          ),
          Divider(color: Colors.black),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/Categories');
              },
              icon: Icon(
                UiIcons.settings_2,
                size: 20,
                color: Theme.of(context).bottomAppBarColor,
              ),
            ),
        ],
      ));

  Widget buildBody() => ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          LocationWidget(),
          HomeSliderWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ServicesWidget(),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 00),
          //   child: SearchBarWidget(),
          // ),
          //
          InkWell(
              onTap: () =>
                  pushWeb(context, url: "https://siyoutech.tn/policy.html"),
              child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Theme.of(context).primaryColor),
                  margin:
                      EdgeInsets.only(top: 5, left: 12, right: 12, bottom: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          // width: 50,
                          // height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage("img/Services/1-03.png"),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          // width: 50,
                          // height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage("img/Services/2-03.png"),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 10, top: 10, bottom: 10, right: 10),
                          // width: 50,
                          // height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage("img/Services/1-03.png"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))),

          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Theme.of(context).primaryColor),
              margin: EdgeInsets.only(
                top: 5,
                left: 10,
                right: 10,
                bottom: 10,
              ),
              // padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  FlashSalesHeaderWidget(),
                  FlashSalesCarouselWidget(
                      heroTag: Text('home_flash_sales'),
                      productsList: Product.ProductsList.flashSalesList),
                ],
              )),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              leading: Icon(
                UiIcons.favorites,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                'Recommended For You',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
          StickyHeader(
            header: CategoriesIconsCarouselWidget(
                heroTag: Text('home_categories_1'),
                categoriesList: Category.CategoriesList.categoriesList,
                onChanged: (id) {
                  setState(() {
                    animationController.reverse().then((f) {
                      _productsOfCategoryList =
                          Category.CategoriesList.categoriesList.firstWhere((category) {
                        return category.id == int.parse(id);
                      }).products;
                      animationController.forward();
                    });
                  });
                }),
            content: CategorizedProductsWidget(
                animationOpacity: animationOpacity,
                productsList: _productsOfCategoryList),
          ),
          // Heading (Brands)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              leading: Icon(
                UiIcons.flag,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                'Brands',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
          StickyHeader(
            header: BrandsIconsCarouselWidget(
                heroTag: Text('home_brand_1'),
                brandsList: Brand.BrandsList.brandsList,
                onChanged: (id) {
                  setState(() {
                    animationController.reverse().then((f) {
                      _productsOfBrandList =
                          Brand.BrandsList.brandsList.firstWhere((brand) {
                        return brand.id == int.parse(id);
                      }).products;
                      animationController.forward();
                    });
                  });
                }),
            content: CategorizedProductsWidget(
                animationOpacity: animationOpacity,
                productsList: _productsOfBrandList),
          ),
        ],
      );
}
