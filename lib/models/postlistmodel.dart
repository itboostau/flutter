class PostList {
  final int error;
  final String articleCategory,
      articleId,
      title,
      updatedDate,
      articleType,
      source,
      videoSource,
      errorMessage;

  PostList({
    this.articleId,
    this.error,
    this.articleCategory,
    this.title,
    this.updatedDate,
    this.articleType,
    this.source,
    this.videoSource,
    this.errorMessage,
  });

  factory PostList.fromJson(Map<String, dynamic> json) {
    return PostList(
      articleId: json['articleId'],
      error: json['error'],
      articleCategory: json['articleCategory'],
      title: json['title'],
      updatedDate: json['updatedDate'],
      articleType: json['articleType'],
      source: json['source'],
      videoSource: json['videoSource'],
      errorMessage: json['errorMessage'],
    );
  }
}
