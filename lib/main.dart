import 'package:flutter/material.dart';
import 'screens/login.dart';

void main() {
  runApp(const MyApp());
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
        return  const Scaffold(
          body:  LoginScreen()
        );
    }
}