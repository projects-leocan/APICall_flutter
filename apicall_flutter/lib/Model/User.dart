
class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
  });

  int id;
  String name;
  String email;
  String username;

  //Todo use for convert json to model class
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    username: json["username"],
  );

  //Todo use for convert model class to json
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "username": username,
  };
}