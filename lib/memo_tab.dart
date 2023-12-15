import 'package:flutter/material.dart';
import 'package:hs_like/memo_info_tab.dart';
import 'package:hs_like/memo_type_tab.dart';

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
          const SizedBox(
            width: 250,
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'everything'),
            ),
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Go')),
          const Text('2023-12-01'),
          const Text('description'),
          ElevatedButton(onPressed: () {}, child: const Text('Edit')),
        ],
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton(
              heroTag: 'memo-type',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MemoTypeTab()));
              },
              child: const Icon(Icons.settings),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton(
              heroTag: 'memo-info',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MemoInfoTab()));
              },
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}
