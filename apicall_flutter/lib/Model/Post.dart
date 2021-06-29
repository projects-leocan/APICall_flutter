
class Post {
  Post({
    required this.title,
    required this.body,
    required this.userId,
    required this.id,
  });

  String title;
  String body;
  int userId;
  int id;

  //Todo use for convert json to model class
  factory Post.fromJson(Map<String, dynamic> json) => Post(
    title: json["title"] == null ? null : json["title"],
    body: json["body"] == null ? null : json["body"],
    userId: json["userId"] == null ? null : json["userId"],
    id: json["id"] == null ? null : json["id"],
  );

  //Todo use for convert model class to json
  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "body": body == null ? null : body,
    "userId": userId == null ? null : userId,
    "id": id == null ? null : id,
  };
}
