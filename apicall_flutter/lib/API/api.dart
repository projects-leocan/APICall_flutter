
import 'dart:convert';
import 'package:http/http.dart';

class API{
  final String postsURL = "https://jsonplaceholder.typicode.com/posts";

  Future<String> getAPIData() async {
    Response res = await get(postsURL);

    if (res.statusCode == 200) {
      return res.body;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}