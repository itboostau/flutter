import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:itboost/global.dart';
import 'package:itboost/models/postlistmodel.dart';
import 'package:http/http.dart' as http;

class PostListConsumer extends ChangeNotifier {
  List<PostList> postList;
  Status status;
  getPostList(int categoryId) async {
    print(categoryId);
    status = Status.loading;
    notifyListeners();
    String _postsUrl;
    if (categoryId != -1) {
      _postsUrl = "https://itboost.com.au/api/category/$categoryId";
    } else {
      _postsUrl = 'https://itboost.com.au/api/articles';
    }
    final response = await http.get(_postsUrl);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      postList =
          parsed.map<PostList>((json) => PostList.fromJson(json)).toList();
      status = Status.done;
      notifyListeners();
    } else {
      status = Status.error;
      notifyListeners();
      throw Exception('Failed to load post');
    }
  }
}
