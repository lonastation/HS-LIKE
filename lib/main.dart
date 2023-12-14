import 'package:flutter/material.dart';

import 'divine_tab.dart';
import 'memo_tab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APP title',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BottomNavBox(),
    );
  }
}

class BottomNavBox extends StatefulWidget {
  const BottomNavBox({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BottomNavBarBoxState();
  }
}

class _BottomNavBarBoxState extends State<BottomNavBox> {
  int _selectedIndex = 0;
  final _widgetOptions = <Widget>[
    const DivineTab(),
    const MemoTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.whatshot), label: 'Like'),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'Memo')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
