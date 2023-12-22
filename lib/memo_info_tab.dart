import 'package:flutter/material.dart';

class MemoInfoTab extends StatefulWidget {
  const MemoInfoTab({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MemoInfoTabState();
  }
}

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class _MemoInfoTabState extends State<MemoInfoTab> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memo Detail'),
      ),
      body: ListView(
        children: <Widget>[
          Row(
            children: [
              SizedBox(width: 100, child: Text('when')),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'when',
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 100, child: Text('type')),
              Expanded(
                  child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
              ))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'what',
                ),
                maxLines: null,
              ))
            ],
          ),
          ElevatedButton(onPressed: () {}, child: Text('Submit'))
        ],
      ),
    );
  }
}
