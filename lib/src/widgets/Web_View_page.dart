import 'package:ecommerce_app_ui_kit/config/utlis.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share/share.dart';

class WebScaffold extends StatefulWidget {
  const WebScaffold({
    Key key,
    this.title,
    this.titleId,
    this.url,
  }) : super(key: key);

  final String title;
  final String titleId;
  final String url;

  @override
  State<StatefulWidget> createState() {
    return new WebScaffoldState();
  }
}

class WebScaffoldState extends State<WebScaffold> {
//  WebViewController _webViewController;
//  bool _isShowFloatBtn = false;

  void _onPopSelected(String value) {
    String _title = widget.title ?? "";
    switch (value) {
      case "browser":
        launchInBrowser(widget.url, title: _title);
        break;
      case "collection":
        break;
      case "share":
        String _url = widget.url;
        Share.share('$_title : $_url');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: new Text(
          widget.title ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        actions: <Widget>[
          // LikeButton(
          //   width: 56.0,
          //   duration: Duration(milliseconds: 500),
          // ),
//          new IconButton(icon: new Icon(Icons.more_vert), onPressed: () {}),
          new PopupMenuButton(
              padding: const EdgeInsets.all(0.0),
              onSelected: _onPopSelected,
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    new PopupMenuItem<String>(
                        value: "browser",
                        child: ListTile(
                            contentPadding: EdgeInsets.all(0.0),
                            dense: false,
                            title: new Container(
                              alignment: Alignment.center,
                              child: new Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.language,
                                    color: Color(0xFF666666),
                                    size: 22.0,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Open in Browser',
                                    // style: TextStyles.listContent,
                                  )
                                ],
                              ),
                            ))),
//                    new PopupMenuItem<String>(
//                        value: "collection",
//                        child: ListTile(
//                            contentPadding: EdgeInsets.all(0.0),
//                            dense: false,
//                            title: new Container(
//                              alignment: Alignment.center,
//                              child: new Row(
//                                children: <Widget>[
//                                  Icon(
//                                    Icons.collections,
//                                    color: Colours.gray_66,
//                                    size: 22.0,
//                                  ),
//                                  Gaps.hGap10,
//                                  Text(
//                                    '??????',
//                                    style: TextStyles.listContent,
//                                  )
//                                ],
//                              ),
//                            ))),
                    new PopupMenuItem<String>(
                        value: "share",
                        child: ListTile(
                            contentPadding: EdgeInsets.all(0.0),
                            dense: false,
                            title: new Container(
                              alignment: Alignment.center,
                              child: new Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.share,
                                    color: Color(0xFF666666),
                                    size: 22.0,
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    '??????',
                                    //style: TextStyles.listContent,
                                  )
                                ],
                              ),
                            ))),
                  ])
        ],
      ),
      body: new WebView(
        onWebViewCreated: (WebViewController webViewController) {
//          _webViewController = webViewController;
//          _webViewController.addListener(() {
//            int _scrollY = _webViewController.scrollY.toInt();
//            if (_scrollY < 480 && _isShowFloatBtn) {
//              _isShowFloatBtn = false;
//              setState(() {});
//            } else if (_scrollY > 480 && !_isShowFloatBtn) {
//              _isShowFloatBtn = true;
//              setState(() {});
//            }
//          });
        },
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
//      floatingActionButton: _buildFloatingActionButton(),
    );
  }

//  Widget _buildFloatingActionButton() {
//    if (_webViewController == null || _webViewController.scrollY < 480) {
//      return null;
//    }
//    return new FloatingActionButton(
//        heroTag: widget.title ?? widget.titleId,
//        backgroundColor: Theme.of(context).primaryColor,
//        child: Icon(
//          Icons.keyboard_arrow_up,
//        ),
//        onPressed: () {
//          _webViewController.scrollTop();
//        });
//  }
}
