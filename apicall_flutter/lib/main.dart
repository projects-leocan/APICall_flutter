// @dart=2.9
import 'dart:convert';

import 'package:apicall_flutter/API/api.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'Model/Post.dart';
import 'Model/User.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // Todo initialize EasyLoading
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key,this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String data='';
  String responseString;
  List<User> userList = new List();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:EdgeInsets.all(20),
                  child: RaisedButton(
                    child: Text("GET API CALL",),
                    textColor: Colors.white,
                    color: Colors.black54,
                    elevation: 10.0,
                    onPressed: (){
                      getApiCall();
                    },

                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: RaisedButton(
                    child: Text("POST API CALL"),
                    textColor: Colors.white,
                    color: Colors.black54,
                    elevation: 10,
                    onPressed: (){
                      postApiCall();
                    },
                  ),
                )

              ],
            ),

            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text('$responseString',style: new TextStyle(fontSize: 16.0,color: Colors.black),),
              ),
            )

          ],
        ),
      ),
    );
  }

  //Todo check the internet connection
  Future<bool> checkInternetConnection() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      // print("Connected to Mobile Network");
      return true;
    } else {
      // print("Unable to connect. Please Check Internet Connection");
      return false;

    }
  }

  //Todo get api call
  getApiCall() async {
    bool isInternet = await checkInternetConnection();
    if(isInternet){
      EasyLoading.show(status: 'loading...');
      var response = await API.getUsers();
      EasyLoading.dismiss();
      setState(() {
        // print(response);
        responseString = response.toString();

        if(responseString.isNotEmpty){
          //Todo jsonParsing (response get in String) (convert String -> json -> Model_List)
          userList = List<User>.from(jsonDecode(response).map((i) => User.fromJson(i)));

          print('-------------');
          print("SIZE:  "+userList.length.toString());
          print('-------------');
          print(userList[0].toJson());
          print(userList[1].toJson());
          print(userList[2].toJson());
          print(userList[3].toJson());
        }
      });
    }

  }

  //Todo post api call
  postApiCall() async {
    bool isInternet = await checkInternetConnection();
    if(isInternet){
      EasyLoading.show(status: 'loading...');

      Map<String, String> headers = {"Content-type": "application/json"};
      String json = '{"title": "Hello", "body": "body text", "userId": 1}';
      var response = await API.createUser(headers,json);
      EasyLoading.dismiss();
      setState(() {
        print(response);
        responseString = response.toString();
        if(responseString.isNotEmpty){
          //Todo jsonParsing (response get in String) (convert String -> json -> Model_Class)
          Post post = Post.fromJson(jsonDecode(response));

          print('-------------');
          print(post.toJson());
        }
      });
    }

  }
}
