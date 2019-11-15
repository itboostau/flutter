class Categories{
  final String title;
  final int articles, id;

  Categories({this.id, this.title, this.articles});
  
  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'],
      title: json['title'],
      articles: json['articles'],
    );
  }
}