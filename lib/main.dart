import 'package:flutter/material.dart';
import 'package:mobile_dolibarr/screens/home.dart';
import 'package:mobile_dolibarr/screens/login.dart';
import 'package:mobile_dolibarr/widgets/bottomTab.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: _navBarItems[selectedIndex].title),
      body: Center(
        child: bodyList[selectedIndex],
      ),
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: selectedIndex,
          selectedItemColor: const Color(0xff1eafe9),
          unselectedItemColor: const Color(0xff757575),
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: _navBarItems),
    );
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text("Home"),
    selectedColor: Colors.blue,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.calendar_month),
    title: const Text("Agenda"),
    selectedColor: Colors.blue,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.people_rounded),
    title: const Text("Provider"),
    selectedColor: Colors.blue,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.shopping_cart),
    title: const Text("Product"),
    selectedColor: Colors.blue,
  ),
];

final bodyList = [
  const HomeScreen('home'),
  const HomeScreen('agenda'),
  const HomeScreen('provider'),
  const HomeScreen('product'),
];