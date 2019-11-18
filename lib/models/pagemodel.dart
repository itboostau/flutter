import 'package:flutter/material.dart';

class PageModel with ChangeNotifier {
  int _page = 0;
  int _categoryId = 0;
  int get page => _page;
  int get categoryId => _categoryId;

  void changePage({int pageId, int categoryId}) {
    _page = pageId;
    if (categoryId != null){
      _categoryId = categoryId;
    }
    notifyListeners();
  }
}