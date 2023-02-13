
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Text(title),
        ),
    );
    throw UnimplementedError();
  }
}