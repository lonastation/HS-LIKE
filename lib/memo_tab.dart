import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:hs_like/memo_info_tab.dart';
import 'package:hs_like/memo_repo.dart';
import 'package:hs_like/memo_type_tab.dart';

class MemoTab extends StatefulWidget {
  const MemoTab({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MemoTabState();
  }
}

class _MemoTabState extends State<MemoTab> {
  MemoType? selectedType;
  List<Memo> memos = <Memo>[];

  Future<void> _fetchData() async {
    memos = await listMemo();
    developer.log(memos.join(','), name: 'memo tab');
  }

  List<Padding> _generateMemoTags(List<String> tagNames) {
    if (tagNames.isEmpty) {
      return List.empty();
    }
    return tagNames.map((name) {
      return Padding(
          padding: const EdgeInsets.fromLTRB(0, 4, 6, 4),
          child: Text(
            name,
            style: const TextStyle(decoration: TextDecoration.underline),
          ));
    }).toList();
  }

  FutureBuilder<List<Memo>> _generateMemos() {
    return FutureBuilder<List<Memo>>(
      future: Future<List<Memo>>(() => listMemo()),
      builder: (BuildContext context, AsyncSnapshot<List<Memo>> snapshot) {
        if (snapshot.hasData) {
          return Wrap(
            children: snapshot.data!.map((e) {
              return Wrap(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        e.occurDate,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Wrap(
                        children: [
                          TextButton(
                              onPressed: () {}, child: const Text('Del')),
                          TextButton(
                              onPressed: () {}, child: const Text('Edit')),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        e.content,
                        style: const TextStyle(
                            color: Colors.deepPurpleAccent, fontSize: 20),
                      ))
                    ],
                  ),
                  Wrap(
                    children: _generateMemoTags(e.tags),
                  )
                ],
              );
            }).toList(),
          );
        }
        return const Wrap(
          children: [Text('no data')],
        );
      },
    );
  }

  FutureBuilder<List<MemoType>> _generateTypes() {
    return FutureBuilder<List<MemoType>>(
      future: Future<List<MemoType>>(() => listType()),
      builder: (BuildContext context, AsyncSnapshot<List<MemoType>> snapshot) {
        if (snapshot.hasData) {
          return DropdownButton<MemoType>(
            value: _setSelectedType(snapshot),
            items: snapshot.data!
                .map<DropdownMenuItem<MemoType>>((MemoType value) {
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
          );
        }
        return DropdownButton<MemoType>(
          value: selectedType,
          items: List.empty(),
          onChanged: (MemoType? value) {},
        );
      },
    );
  }

  MemoType? _setSelectedType(AsyncSnapshot<List<MemoType>> snapshot) {
    if (snapshot.hasData) {
      if (snapshot.data!.isNotEmpty) {
        selectedType = snapshot.data!.first;
      }
      return selectedType;
    }
    return MemoType(title: '-');
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(spacing: 10, children: [
                  _generateTypes(),
                  const SizedBox(
                    width: 220,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                ]),
                TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20)),
                    child: const Text('搜索')),
              ],
            ),
          ),
          _generateMemos(),
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
