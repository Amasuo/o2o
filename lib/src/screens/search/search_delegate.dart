import 'package:ecommerce_app_ui_kit/config/search.dart';
import 'package:ecommerce_app_ui_kit/src/models/SearchModal.dart';
import 'package:flutter/material.dart' hide SearchDelegate;
import 'package:provider/provider.dart';
import 'search_suggestions.dart';

class DefaultSearchDelegate extends SearchDelegate {
  SearchHistoryModel _searchHistoryModel = SearchHistoryModel();
 // SearchHotKeyModel _searchHotKeyModel = SearchHotKeyModel();

  @override
  ThemeData appBarTheme(BuildContext context) {
    var theme = Theme.of(context);
    return super.appBarTheme(context).copyWith(
      
        primaryColor: theme.scaffoldBackgroundColor,
        primaryColorBrightness: theme.brightness);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
            showSuggestions(context);
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
//    if (query.length < 4) {
//      return Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Center(
//            child: Text(
//              "Search term must be longer than two letters.",
//            ),
//          )
//        ],
//      );
//    }
    debugPrint('buildResults-query' + query);
    if (query.length > 0) {
      return Container();
    }
    return SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchHistoryModel>.value(value: _searchHistoryModel),
       // ChangeNotifierProvider<SearchHotKeyModel>.value(value: _searchHotKeyModel),
      ],
      child: SearchSuggestions(delegate: this),
    );
  }

  @override
  void close(BuildContext context, result) {
    _searchHistoryModel.dispose();
    //_searchHotKeyModel.dispose();
    super.close(context, result);
  }
}
