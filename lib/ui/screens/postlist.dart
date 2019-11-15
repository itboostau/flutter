import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itboost/global.dart';
import 'package:itboost/models/postlistmodel.dart';
import 'package:itboost/ui/screens/post.dart';
import 'package:itboost/ui/widgets/blog_post_container.dart';
import 'package:http/http.dart' as http;

class PostListScreen extends StatelessWidget {
  final String categoryId;

  const PostListScreen({Key key, this.categoryId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: MyColors.lightGrey,
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset("assets/logo.png", height: 41, width: 41),
                  Column(
                    children: <Widget>[
                      Text(
                        "ITBOOST",
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .apply(color: MyColors.magenta, fontWeightDelta: 2),
                      ),
                      Text(
                        "Australia",
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .apply(color: MyColors.orange, fontWeightDelta: 2),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Latest Articles",
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .apply(color: Colors.black, fontWeightDelta: 2),
                  ),
                  Text(
                    "We write up articles on Apps, Websites and SEO",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle
                        .apply(color: MyColors.darkGrey),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: PostsListWidget(categoryId: categoryId),
            )
          ],
        ),
      ),
    );
  }
}

Future<List<PostList>> _getPostList(String categoryId) async {
  String _postsUrl;
  if (categoryId != null) {
    _postsUrl = "https://itboost.com.au/api/category/$categoryId";
  } else {
    _postsUrl = 'https://itboost.com.au/api/articles';
  }
  final response =
        await http.get(_postsUrl);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<PostList>((json) => PostList.fromJson(json)).toList();
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

class PostsListWidget extends StatefulWidget {
  final String categoryId;
  const PostsListWidget({
    Key key,
    this.categoryId,
  }) : super(key: key);

  @override
  _PostsListWidgetState createState() => _PostsListWidgetState();
}

class _PostsListWidgetState extends State<PostsListWidget> {
  Future<List<PostList>> post;
  @override
  void initState() {
    super.initState();
    if (widget.categoryId == null) {
      post = _getPostList(null);
    } else {
      post = _getPostList(widget.categoryId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PostList>>(
      future: post,
      builder: (ctx, result) {
        print(result);
        if (result.hasData) {
          return ListView.builder(
            itemCount: result.data.length,
            shrinkWrap: true,
            itemBuilder: (ctx, i) {
              return BlogPostContainer(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) =>
                              PostScreen(articleId: result.data[i].articleId)));
                },
                category: "${result.data[i].articleCategory}",
                title: "${result.data[i].title}",
                imgUrl: "${result.data[i].source}",
                type: BlogPostType.seo,
                date: "${result.data[i].updatedDate}",
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
