class Post {
  final String title;
  final String body;
  final String userId;
  final String imageUrl;
  final String datetime;

  Post({
    required this.title,
    required this.body,
    required this.userId,
    required this.imageUrl,
    required this.datetime,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json["title"],
      body: json["body"],
      userId: "Publisher ${json["userId"]}",
      imageUrl: "https://picsum.photos/seed/${json["id"]}/600/400",
      datetime: "Jan 01  2024 12:00 AM",
    );
  }
}
