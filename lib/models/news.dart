class News {
  String headline = 'This is a [valid] headline';
  String link = "https://example.com";

  News(this.headline, this.link);

  News.fromJson(Map<String, dynamic> json)
      : headline = json['headline'],
        link = json['link'];
}