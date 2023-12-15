import 'package:flutter/material.dart';

class MemoTab extends StatefulWidget {
  const MemoTab({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MemoTabState();
  }
}

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class _MemoTabState extends State<MemoTab> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          DropdownButton<String>(
            value: dropdownValue,
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                dropdownValue = value!;
              });
            },
          ),
          Text('2023-12-01 mc2'),
          Text('2023-11-26 unit'),
        ],
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.settings),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}
