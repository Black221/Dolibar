import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_dolibarr/utils/utils.dart';
class HomeScreen extends StatelessWidget {
  HomeScreen(this.title, {super.key});

  final String title;
  final List ModuleList = [
    {
      'icon':  Icons.group,
      'title': 'Fournisseurs',
      'count': 3,
    },
    {
      'icon':  Icons.shopping_cart,
      'title': 'Produits',
      'count': 5,
    },
    {
      'icon':  Icons.calendar_month,
      'title': 'Evenement',
      'count': 8,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB( 0, 40.0, 0.0, 40.0),
            height: 120,
            decoration: BoxDecoration(

              border:  Border.all(
                  color: const Color.fromARGB(255,38, 60, 92),
                  width: 2,
                  style: BorderStyle.solid,

              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset("images/dolibarr.png", height: 90,),
          ),
          Container(
            width: double.infinity,
            color: const Color.fromARGB(255,38, 60, 92),
            padding: const EdgeInsets.fromLTRB( 10, 10.0, 10.0, 10.0),
            child: const Center(
              child: Text("Statistique", selectionColor: Colors.white),
            ),
          ),
          Expanded (child :ListView.builder(
            itemCount: ModuleList.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(100,99, 99, 99),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    margin: const EdgeInsets.fromLTRB( 10, 10.0, 10.0, 10.0),
                    child: Icon(ModuleList[index]['icon'] as IconData?, color: const Color.fromARGB(255,38, 60, 92), size: 50,),
                  ),
                  Column(
                    children: [
                      Text(ModuleList[index]['title']),
                      Text(ModuleList[index]['count'].toString())
                    ],
                  )
                ],
              );
            },
          )),
        ],
      ),

    );
  }
}