import 'package:ecommerce_app_ui_kit/config/vs_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServicesWidget extends StatefulWidget {
  @override
  _ServicesWidgetState createState() => _ServicesWidgetState();
}

class _ServicesWidgetState extends State<ServicesWidget> {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return _contentServices(context);
  }

  Widget _contentServices(BuildContext context) {
    List<ModelServices> listServices = List();

    listServices.add(new ModelServices(
        title: "Categories", img: "img/Services/ic_accessory.png"));
    listServices.add(new ModelServices(
        title: "Stores", img: "img/Services/ic_shopping.png"));
    listServices.add(new ModelServices(
        title: "Electricity", img: "img/Services/ic_electric.png"));
    listServices.add(
        new ModelServices(title: "Cashback", img: "img/Services/ic_sell.png"));
    listServices.add(new ModelServices(
        title: "Movies", img: "img/Services/ic_entertainmmment.png"));
    listServices.add(
        new ModelServices(title: "Flight", img: "img/Services/ic_plane.png"));

    listServices.add(new ModelServices(
      title: "Hotels",
      img: "img/Services/ic_hotel.png",
      callback: (context) =>
          Navigator.of(context).pushNamed('/Tabs', arguments: 4),
    ));
    listServices.add(new ModelServices(
      title: "Trains",
      img: "img/Services/ic_train.png",
      callback: (context) =>
          Navigator.of(context).pushNamed('/Tabs', arguments: 4),
    ));
    // listServices.add(new ModelServices(
    //   title: "Following",
    //   img: "img/Services/receive.png",
    //   callback: (context) =>
    //       Navigator.of(context).pushNamed('/Tabs', arguments: 0),
    // ));
    listServices.add(new ModelServices(
        title: "Categories", img: "img/Services/ic_accessory.png"));
    listServices.add(new ModelServices(
        title: "Stores", img: "img/Services/ic_shopping.png"));
    listServices.add(new ModelServices(
        title: "Electricity", img: "img/Services/ic_electric.png"));
    listServices.add(
        new ModelServices(title: "Cashback", img: "img/Services/ic_sell.png"));
    listServices.add(new ModelServices(
        title: "Movies", img: "img/Services/ic_entertainmmment.png"));
    listServices.add(
        new ModelServices(title: "Flight", img: "img/Services/ic_plane.png"));

    listServices.add(new ModelServices(
      title: "Hotels",
      img: "img/Services/ic_hotel.png",
      callback: (context) =>
          Navigator.of(context).pushNamed('/Tabs', arguments: 4),
    ));
    listServices.add(new ModelServices(
      title: "Trains",
      img: "img/Services/ic_train.png",
      callback: (context) =>
          Navigator.of(context).pushNamed('/Tabs', arguments: 4),
    ));

    return SizedBox(
        height: MediaQuery.of(context).size.height / 4,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: VsScrollbar(
              controller: _scrollController,
              scrollDirection: Axis.horizontal, // @REQUIRED
              allowDrag: false,
              color: Theme.of(context).accentColor,
              radius: 50,
              thickness: 5,
              isAlwaysShown: true,
              scrollbarFadeDuration: Duration(milliseconds: 500),
              scrollbarTimeToFade: Duration(milliseconds: 800),
              child: GridView(
                physics: BouncingScrollPhysics(),
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: listServices.map((value) {
                  return GestureDetector(
                    onTap: () {
                      value.callback(context);
                      print('${value.title}');
                    },
                    child: Container(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              child: Image.asset(
                                '${value.img}',
                                height: 45,
                                width: 45,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('${value.title}',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10)
                                // style: GoogleFonts.montserrat(
                                //   textStyle:
                                //       Theme.of(context).textTheme.headline3,
                                // ).copyWith(
                                //     fontSize: 10, fontWeight: FontWeight.w100),
                                )
                          ],
                        )),
                  );
                }).toList(),
              )),
        ));
  }
}

class ModelServices {
  String title, img;
  void Function(BuildContext) callback;
  ModelServices({this.title, this.img, this.callback});
}
