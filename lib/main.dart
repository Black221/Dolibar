import 'package:flutter/material.dart';
import 'package:mobile_dolibarr/screens/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(const MyApp());
}

Future<String> sayHello () async {


  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(Uri.parse('http://localhost:8080/dolibarr/api/index.php/users?DOLAPIKEY=lhackerskey'));
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as List< dynamic>;
    print('Number of books about http: ${jsonResponse[0]['lastname']}.');
    return jsonResponse[0]['lastname'];
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return "";
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var title = "";
    return MaterialApp(
      title:  title
      ,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var title = "";
    sayHello().then((value) => title= value);
    return  Scaffold(
      body: LoginScreen(title),
    );
  }
}
