import 'package:flutter/material.dart';
import 'calendar.dart';
import 'provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'home.dart';
import 'login.dart';

class MainScreen extends StatefulWidget {
    const MainScreen({Key? key}) : super(key: key);

    @override
    State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
    int selectedIndex = 0;

    @override
    Widget build(BuildContext context) {
        return  Scaffold(
            body:  bodyList[selectedIndex],
            bottomNavigationBar: SalomonBottomBar(
                currentIndex: selectedIndex,
                selectedItemColor: const Color(0xff1eafe9),
                unselectedItemColor: const Color(0xff757575),
                onTap: (index) {
                    setState(() {
                        selectedIndex = index;
                    });
                },
                items: _navBarItems
            ),
        );
    }
}

final _navBarItems = [
    SalomonBottomBarItem(
        icon: const Icon(Icons.home),
        title: const Text("Home"),
        selectedColor: Color.fromARGB(255,38, 60, 92),
    ),
    SalomonBottomBarItem(
        icon: const Icon(Icons.calendar_month),
        title: const Text("Agenda"),
        selectedColor: Color.fromARGB(255,38, 60, 92),
    ),
    SalomonBottomBarItem(
        icon: const Icon(Icons.people_rounded),
        title: const Text("Provider"),
        selectedColor: Color.fromARGB(255,38, 60, 92),
    ),
    SalomonBottomBarItem(
        icon: const Icon(Icons.shopping_cart),
        title: const Text("Product"),
        selectedColor: Color.fromARGB(255,38, 60, 92),
    ),
];

final bodyList = [
    HomeScreen('home'),
    const CalendarScreen(),
    const ProviderScreen(),
    HomeScreen('product'),
];