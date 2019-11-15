import 'package:flutter/material.dart';
import 'package:itboost/global.dart';

class BlogPostContainer extends StatelessWidget {
  final String title, imgUrl, category, date;
  final BlogPostType type;
  final GestureTapCallback onTap;

  const BlogPostContainer(
      {Key key,
      @required this.title,
      @required this.imgUrl,
      @required this.type,
      @required this.category,
      this.date,
      @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height / 2.5,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.blue),
          borderRadius: BorderRadius.circular(25.0),
          color: MyColors.blue,
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: <Widget>[
                  Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: MyColors.orange)),
                  SizedBox(width: 9),
                  Text(
                    "$category",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle
                        .apply(color: MyColors.orange),
                  ),
                  Spacer(),
                  date?.isEmpty != null
                      ? Text(
                          "$date",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle
                              .apply(color: Colors.white),
                        )
                      : Container(),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                width: double.infinity,
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: MyColors.lightGrey,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
              ),
              child: Text(
                "$title $title $title $title",
                style: Theme.of(context)
                    .textTheme
                    .title
                    .apply(color: MyColors.darkGrey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
