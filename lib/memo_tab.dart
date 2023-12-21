import 'package:flutter/material.dart';
import 'package:hs_like/memo_info_tab.dart';
import 'package:hs_like/memo_repo.dart';
import 'package:hs_like/memo_type_tab.dart';
import 'dart:developer' as developer;

class MemoTab extends StatefulWidget {
  const MemoTab({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MemoTabState();
  }
}

class _MemoTabState extends State<MemoTab> {
  MemoType? selectedType;
  List<MemoType> types = <MemoType>[];
  List<Tag> tags = <Tag>[];
  List<Memo> memos = <Memo>[];

  Future<void> _fetchData() async {
    types = await listType();
    if (types.isNotEmpty) {
      selectedType = types.first;
    }
    tags = await listTag(selectedType?.id);
    memos = await listMemo();
    developer.log(types.join(','), name: 'memo tab');
    developer.log(tags.join(','), name: 'memo tab');
    developer.log(memos.join(','), name: 'memo tab');
  }

  List<Chip> _generateTags() {
    if (tags.isEmpty) {
      return List.empty();
    }
    return tags.map((e) {
      return Chip(
        label: Text(e.title),
        backgroundColor: Colors.lightBlueAccent,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      );
    }).toList();
  }

  List<Chip> _generateMemoTags(List<String> tagNames) {
    if (tagNames.isEmpty) {
      return List.empty();
    }
    return tagNames.map((name) {
      return Chip(
        label: Text(name),
        backgroundColor: Colors.lightBlueAccent,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      );
    }).toList();
  }

  List<Wrap> _generateMemos() {
    if (memos.isEmpty) {
      return List.empty();
    }
    return memos.map((e) {
      return Wrap(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(e.occurDate),
              Wrap(
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text('Del')),
                  ElevatedButton(onPressed: () {}, child: const Text('Edit')),
                ],
              ),
            ],
          ),
          Row(
            children: [Expanded(child: Text(e.content))],
          ),
          Wrap(
            children: _generateMemoTags(e.tags),
          )
        ],
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(spacing: 10, children: [
                DropdownButton<MemoType>(
                  value: selectedType,
                  items:
                      types.map<DropdownMenuItem<MemoType>>((MemoType value) {
                    return DropdownMenuItem<MemoType>(
                      value: value,
                      child: Text(value.title),
                    );
                  }).toList(),
                  onChanged: (MemoType? value) {
                    setState(() {
                      selectedType = value!;
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
          Wrap(
            children: _generateTags(),
          ),
          Wrap(
            children: _generateMemos(),
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
