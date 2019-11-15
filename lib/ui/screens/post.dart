import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:itboost/global.dart';
import 'package:itboost/models/postmodel.dart';
import 'package:http/http.dart' as http;

Future<List<PostModel>> _getPost(String articleId) async {
  final response =
      await http.get('https://itboost.com.au/api/articles/$articleId');

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    print(parsed);
    return parsed.map<PostModel>((json) => PostModel.fromJson(json)).toList();
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

class PostScreen extends StatefulWidget {
  final String articleId;

  const PostScreen({Key key, @required this.articleId}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  Future<List<PostModel>> _post;
  @override
  void initState() {
    super.initState();
    print(widget.articleId);
    _post = _getPost(widget.articleId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: MyColors.blue),
        title: Text(
          "Blog Post",
          style: Theme.of(context).textTheme.title.apply(color: MyColors.blue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: FutureBuilder<List<PostModel>>(
          future: _post,
          builder: (ctx, result) {
            print(result);
            if (result.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.network(
                    "${result.data[0].source}",
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 11.0,
                  ),
                  Text(
                    "${result.data[0].title}",
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .apply(color: MyColors.magenta),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Html(
                    data: "${result.data[0].description}",
                    useRichText: true,
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
