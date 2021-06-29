import 'package:http/http.dart' as http;

const baseUrl = "https://jsonplaceholder.typicode.com";
class API{
  //Todo Get API call to get the all users
  static Future getUsers() async {
    var url = baseUrl + "/users";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw "";
    }
  }

  //Todo Post API call to add user
  static Future createUser(Map<String, String> headers,String json) async {
    var url = baseUrl + "/posts";
    var response = await http.post(url,headers: headers,body: json);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw "";
    }

  }
}