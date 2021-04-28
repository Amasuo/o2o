import 'package:ecommerce_app_ui_kit/config/ui_icons.dart';
import 'package:ecommerce_app_ui_kit/src/models/categoryFromJson.dart' as Category;
import 'package:ecommerce_app_ui_kit/src/models/productFromJson.dart' as Product;
import 'package:ecommerce_app_ui_kit/src/models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Content extends StatefulWidget {
  int index;
  List<Product.Result> _list;

  Content(this.index,this._list);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  int countTopRankings, countMoreToLove;

  Widget incrementCountTopRankings() {
    countTopRankings++;
    return Container();
  }

  Widget incrementCountMoreToLove() {
    countMoreToLove++;
    return Container();
  }

  Widget resetCounts() {
    countMoreToLove =0;
    countTopRankings =0;
    return Container();
  }

  @override
  void initState() {
    countMoreToLove =0;
    countTopRankings =0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Container(
          color: Colors.grey[200],
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular(6)
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child:
                    Wrap(
                      direction: Axis.horizontal,
                      children: [
                        for (Product.Result p in widget._list)
                          InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed('/Product',
                                  arguments: new RouteArgument(
                                      argumentsList: [p, Text('categorized_products_grid')],
                                      id: p.id));
                            },
                            child: Padding(
                              padding: new EdgeInsets.fromLTRB(5, 0, 10, 20),
                              child:
                              Column(
                                children: [
                                  Container(
                                    width: 65,
                                    height: 65,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[50],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(14)
                                      ),
                                    ),
                                    child: (p.image1 != null) ? Image.network(p.image1) : Image.asset('img/product.png'),
                                  ),
                                  Container(
                                    width: Get.width/6,
                                    child: Text(
                                      p.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.wysiwyg,size: 20,color: Colors.red[800],),
                    ),
                    Text(
                      'Top Rankings',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                child: Container(
                  child: Row(
                    children: [
                      for (Product.Result p in widget._list)
                        if(countTopRankings<3)
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed('/Product',
                                  arguments: new RouteArgument(
                                      argumentsList: [p, Text('categorized_products_grid')],
                                      id: p.id));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Container(
                                height: Get.height/3.7,
                                width: Get.width/3.5,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(14)
                                  ),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.red[50],
                                        Colors.white,
                                      ]
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    incrementCountTopRankings(),
                                    Container(
                                      height: Get.height/5.5,
                                      width: Get.width/5,
                                      child: (p.image1 != null) ? Image.network(p.image1) : Image.asset('img/product.png') ,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 7),
                                      child: Container(
                                        width: Get.width/6,
                                        child: Text(
                                          p.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        height: Get.height/30,
                                        width: Get.width/5,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: [
                                                  Colors.red[800],
                                                  Colors.red[600]
                                                ]
                                            ),
                                            color: Colors.deepPurple,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(14)
                                            )
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              child: Padding(
                                                child: Icon(
                                                  Icons.local_fire_department_sharp,
                                                  color: Colors.white,
                                                  size: 13,
                                                ),
                                                padding: EdgeInsets.only(left: 4),
                                              ),
                                              alignment: Alignment.centerLeft,
                                            ),
                                            Positioned(
                                                left: Get.width/20,
                                                top: Get.height/120,
                                                child: SizedBox(
                                                  width: 50,
                                                  child: FittedBox(
                                                    child: Text(
                                                      p.soldCount.toString()+' orders',
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                    fit: BoxFit.scaleDown,
                                                  ),
                                                )
                                            ),
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(Icons.favorite_border_outlined, size: 20,),
                      ),
                      Text(
                        'More to Love',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  )
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                child: Container(
                  child: Row(
                    children: [
                      for (Product.Result p in widget._list)
                        if(countMoreToLove<3)
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed('/Product',
                                  arguments: new RouteArgument(
                                      argumentsList: [p, Text('categorized_products_grid')],
                                      id: p.id));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Container(
                                height: Get.height/3.2,
                                width: Get.width/2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(14)
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    incrementCountMoreToLove(),
                                    Container(
                                      height: Get.height/5,
                                      child: (p.image1 != null) ? Image.network(p.image1) : Image.asset('img/product.png'),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Column(
                                          children: [
                                            Expanded(
                                                child: Align(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 10),
                                                    child: Text(
                                                      p.name,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 13
                                                      ),
                                                    ),
                                                  ),
                                                  alignment: Alignment.centerLeft,
                                                )
                                            ),
                                            Expanded(
                                                child: Stack(
                                                  children: [
                                                    Align(
                                                      child: Padding(
                                                        padding: EdgeInsets.only(left: 10),
                                                        child: Text(
                                                          p.price.toString(),
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                      ),
                                                      alignment: Alignment.centerLeft,
                                                    ),
                                                    Align(
                                                      child: Padding(
                                                        padding: EdgeInsets.only(right: 7),
                                                        child: Builder(
                                                          builder: (context) => InkWell(
                                                            onTap: () {
                                                              Scaffold.of(context).showSnackBar(SnackBar(
                                                                content: Text('Added to Cart'),
                                                                duration: Duration(seconds: 1),
                                                              ));
                                                            },
                                                            child: Icon(UiIcons.shopping_cart),
                                                          ),
                                                        ),
                                                      ),
                                                      alignment: Alignment.centerRight,
                                                    ),
                                                  ],
                                                )
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      resetCounts(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}