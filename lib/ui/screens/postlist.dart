import 'package:flutter/material.dart';
import 'package:itboost/global.dart';
import 'package:itboost/models/pagemodel.dart';
import 'package:itboost/models/postlistconsumer.dart';
import 'package:itboost/models/postlistmodel.dart';
import 'package:itboost/ui/screens/post.dart';
import 'package:itboost/ui/widgets/blog_post_container.dart';
import 'package:provider/provider.dart';

class PostListScreen extends StatelessWidget {
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
              child: PostsListWidget(),
            )
          ],
        ),
      ),
    );
  }
}

class PostsListWidget extends StatefulWidget {
  @override
  _PostsListWidgetState createState() => _PostsListWidgetState();
}

class _PostsListWidgetState extends State<PostsListWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostListConsumer>(
      builder: (context, result, _) {
        if (result.status == Status.done) {
          return ListView.builder(
            itemCount: result.postList.length,
            shrinkWrap: true,
            itemBuilder: (ctx, i) {
              return BlogPostContainer(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => PostScreen(
                              articleId: result.postList[i].articleId)));
                },
                category: "${result.postList[i].articleCategory}",
                title: "${result.postList[i].title}",
                imgUrl: "${result.postList[i].source}",
                type: BlogPostType.seo,
                date: "${result.postList[i].updatedDate}",
              );
            },
          );
        } else if (result.status == Status.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (result.status == Status.error) {
          return Center(
            child: Column(
              children: <Widget>[
                Text("Error"),
                RaisedButton(
                  child: Text("Try Again"),
                  onPressed: () {
                    result.getPostList(Provider.of<PageModel>(context, listen: false).categoryId);
                  },
                )
              ],
            ),
          );
        }
      },
    );
  }
}
