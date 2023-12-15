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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(spacing: 10, children: [
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
                  width: 150,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'everything'),
                  ),
                ),
              ]),
              ElevatedButton(onPressed: () {}, child: const Text('Go')),
            ],
          ),
          const Wrap(
            children: [
              Chip(
                label: Text('unit'),
                backgroundColor: Colors.purpleAccent,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),
              Chip(
                label: Text('mc2'),
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),
            ],
          ),
          Wrap(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('2023-12-01'),
                  Wrap(
                    children: [
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Del')),
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Edit')),
                    ],
                  ),
                ],
              ),
              const Row(
                children: [
                  Expanded(
                      child: Text(
                          'description about hs, who, where, how, what, everything can be recorded here'))
                ],
              ),
              const Wrap(
                children: [
                  Chip(
                    label: Text('unit'),
                    backgroundColor: Colors.amberAccent,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  ),
                  Chip(
                    label: Text('mc2'),
                    backgroundColor: Colors.lightBlueAccent,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  ),
                ],
              )
            ],
          ),
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
