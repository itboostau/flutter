import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itboost/global.dart';
import 'package:itboost/models/postlistmodel.dart';
import 'package:itboost/ui/screens/post.dart';
import 'package:itboost/ui/widgets/blog_post_container.dart';
import 'package:itboost/ui/widgets/homescreenheader.dart';
import 'package:http/http.dart' as http;

Future<List<PostList>> _getPostList() async {
  final response = await http.get('https://itboost.com.au/api/homepage');

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed
        .map<PostList>((json) => PostList.fromJson(json))
        .toList();
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: HomeScreenHeader(),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Learn & grow your business',
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'Apps, Websites and SEO',
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .apply(color: MyColors.orange),
              ),
            ],
          ),
        ),
        PostListContainerWidget(),
        SizedBox(
          height: 15.0,
        )
      ],
    );
  }
}

class PostListContainerWidget extends StatefulWidget {
  const PostListContainerWidget({
    Key key,
  }) : super(key: key);

  @override
  _PostListContainerWidgetState createState() =>
      _PostListContainerWidgetState();
}

class _PostListContainerWidgetState
    extends State<PostListContainerWidget> {
  Future<List<PostList>> post;
  @override
  void initState() {
    super.initState();
    post = _getPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: FutureBuilder<List<PostList>>(
        future: post,
        builder: (ctx, result) {
          if (result.hasData)
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: result.data.length,
              itemBuilder: (BuildContext context, int index) {
                return BlogPostContainer(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) =>
                            PostScreen(articleId: result.data[index].articleId),
                      ),
                    );
                  },
                  category: "${result.data[index].articleCategory}",
                  title: "${result.data[index].title}",
                  imgUrl:
                      "${result.data[index].source}",
                  type: BlogPostType.apps,
                );
              },
            );
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
