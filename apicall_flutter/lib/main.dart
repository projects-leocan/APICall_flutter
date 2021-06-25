// @dart=2.9
import 'package:apicall_flutter/API/api.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: [
            Column(
              children: [
                RaisedButton(
                    color: Colors.blue,
                    child: const Text("API Call"),
                    onPressed: () async {
                      // Todo check internet connection
                      bool internet = await checkInternetConnection();
                      if(internet){
                        //Todo show the loader
                        EasyLoading.show(status: 'loading...');

                        //Todo create API call to get data
                        String response = await API().getAPIData();

                        //Todo hide the loader when data get successfully
                        EasyLoading.dismiss();

                        //Todo show the data when data get from the API
                        setState(() {
                          data = response;
                        });
                      }
                    }),
                RaisedButton(
                    color: Colors.blue,
                    child: const Text("Clear"),
                    onPressed: () async {
                      setState(() {
                        data = '';
                      });
                    }),
                Text(data),

              ],
            ),
          ],
        ),
      ),
    );
  }
  static Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
