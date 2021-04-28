import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app_ui_kit/config/app_config.dart' as config;
import 'package:ecommerce_app_ui_kit/src/models/slider.dart';
import 'package:ecommerce_app_ui_kit/src/models/slider.dart' as prefix0;
import 'package:flutter/material.dart';

class HomeSliderWidget extends StatefulWidget {
  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  int _current = 0;
  SliderList _sliderList = new SliderList();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      //fit: StackFit.expand,
      children: <Widget>[
        CarouselSlider(
          //aspectRatio: 16/9,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          height: MediaQuery.of(context).size.height / 5.5,
          viewportFraction: 1.06,
          onPageChanged: (index) {
            setState(() {
              _current = index;
            });
          },
          items: _sliderList.list.map((prefix0.Slider slide) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 00, horizontal: 20),
                  height: MediaQuery.of(context).size.height / 5.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(slide.image), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(6),
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Theme.of(context).hintColor.withOpacity(0.2),
                    //       offset: Offset(0, 4),
                    //       blurRadius: 9)
                    // ],
                  ),
                  child: Container(
                    alignment: AlignmentDirectional.bottomEnd,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: config.App(context).appWidth(40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            slide.description,
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .merge(TextStyle(height: 0.9)),
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.fade,
                            maxLines: 3,
                          ),
                          FlatButton(
                            onPressed: () {
//                              Navigator.of(context).pushNamed('/Checkout');
                            },
                            padding: EdgeInsets.symmetric(vertical: 5),
                            color: Theme.of(context).accentColor,
                            shape: StadiumBorder(),
                            child: Text(
                              slide.button,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: -5,
          
           right: 50,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: _sliderList.list.map((prefix0.Slider slide) {
              return Container(
                width: 7.0,
                height: 5.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    color: _current == _sliderList.list.indexOf(slide)
                        ? Theme.of(context).hintColor
                        : Theme.of(context).hintColor.withOpacity(0.3)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
