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
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: const Row(
              children: [
                SizedBox(width: 80, child: Text('when')),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'date only, yyyy-MM-dd',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Row(
              children: [
                const SizedBox(width: 80, child: Text('type')),
                Expanded(
                    child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  itemHeight: 70,
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
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 2),
            // alignment: Alignment.centerLeft,
            child: const Text('what happened?'),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: const Wrap(
              children: [
                Chip(
                  label: Text('公演'),
                  backgroundColor: Colors.deepPurpleAccent,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
                Chip(
                  label: Text('抖音'),
                  backgroundColor: Colors.deepPurpleAccent,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
                Chip(
                  label: Text('小红书'),
                  backgroundColor: Colors.deepPurpleAccent,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 16, 20, 40),
            child: const Row(
              children: [
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'say something about hs please...',
                  ),
                  maxLines: null,
                ))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Expanded(
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text('Submit')))
            ,
          ),
        ],
      ),
    );
  }
}
