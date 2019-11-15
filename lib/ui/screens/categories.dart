import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itboost/global.dart';
import 'package:http/http.dart' as http;
import 'package:itboost/models/categoriesmodel.dart';
import 'package:itboost/ui/screens/postlist.dart';

Future<List<Categories>> _getCategories() async {
  final response = await http.get('https://itboost.com.au/api/category');

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Categories>((json) => Categories.fromJson(json)).toList();
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff6f4f9),
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Categories",
            style: Theme.of(context)
                .textTheme
                .headline
                .apply(color: MyColors.blue, fontWeightDelta: 2),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Choose a category to start",
            style: Theme.of(context)
                .textTheme
                .headline
                .apply(color: MyColors.darkGrey, fontWeightDelta: 2),
          ),
          SizedBox(
            height: 9.0,
          ),
          Expanded(
            child: _ListCategoriesWidget(),
          )
        ],
      ),
    );
  }
}

class _ListCategoriesWidget extends StatefulWidget {
  @override
  __ListCategoriesWidgetState createState() => __ListCategoriesWidgetState();
}

class __ListCategoriesWidgetState extends State<_ListCategoriesWidget> {
  Future<List<Categories>> _categories;
  @override
  void initState() {
    super.initState();
    _categories = _getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Categories>>(
      future: _categories,
      builder: (ctx, result) {
        if (result.hasData) {
          print("I got data");
          return ListView(
            children: List.generate(
              result.data.length,
              (i) {
                return CategoryContainer(
                  itemCount: result.data[i].articles,
                  title: "${result.data[i].title}",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => PostListScreen(
                            categoryId: result.data[i].id.toString()),
                      ),
                    );
                  },
                );
              },
            ),
          );
        } else {
          print("I got no data");
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class CategoryContainer extends StatelessWidget {
  final String title;
  final int itemCount;
  final GestureTapCallback onTap;
  const CategoryContainer({
    Key key,
    @required this.title,
    @required this.itemCount,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 19.0, horizontal: 5.0),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(blurRadius: 5, offset: Offset(0, 3), color: Colors.grey)
            ],
            borderRadius: BorderRadius.circular(15.0)),
        height: 150,
        child: Row(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "$title",
                  style: Theme.of(context)
                      .textTheme
                      .display1
                      .apply(color: Colors.black, fontWeightDelta: 2),
                ),
                Text(
                    // "${articlesInfo.seo.articleCount}",
                    '$itemCount',
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .apply(color: MyColors.blue, fontWeightDelta: 2)),
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(15),
              decoration:
                  BoxDecoration(color: MyColors.orange, shape: BoxShape.circle),
              child: Icon(Icons.search),
            )
          ],
        ),
      ),
    );
  }
}
