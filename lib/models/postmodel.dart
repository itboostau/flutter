class PostModel {
  final String articleCategory,
      title,
      source,
      updatedDate,
      description,
      articleId;

  PostModel(
      {this.articleCategory,
      this.title,
      this.description,
      this.updatedDate,
      this.source,
      this.articleId});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      articleId: json['articleId'],
      articleCategory: json['articleCategory'],
      description: json['description'],
      title: json['title'],
      updatedDate: json['updatedDate'],
      source: json['source'],
    );
  }
}
