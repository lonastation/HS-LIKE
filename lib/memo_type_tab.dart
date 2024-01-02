import 'package:flutter/material.dart';
import 'package:hs_like/memo_repo.dart';

class MemoTypeTab extends StatefulWidget {
  const MemoTypeTab({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MemoTypeTabState();
  }
}

class _MemoTypeTabState extends State<MemoTypeTab> {
  MemoType? selectedType;

  FutureBuilder<List<Tag>> _drawTags() {
    return FutureBuilder<List<Tag>>(
      future: Future<List<Tag>>(() => listTag(selectedType?.id)),
      builder: (BuildContext context, AsyncSnapshot<List<Tag>> snapshot) {
        if (snapshot.hasData) {
          List<Widget> tagsBox = [];
          tagsBox.addAll(snapshot.data!.map((e) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(e.title),
                Wrap(
                  children: [
                    ElevatedButton(onPressed: () {}, child: const Text('Del')),
                    ElevatedButton(onPressed: () {}, child: const Text('Edit')),
                  ],
                )
              ],
            );
          }));
          tagsBox.add(Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: ElevatedButton(
                onPressed: () {}, child: const Icon(Icons.add)),
          ));
          return Wrap(
            children: tagsBox,
          );
        }
        return Wrap(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ElevatedButton(
                  onPressed: () {}, child: const Icon(Icons.add)),
            )
          ],
        );
      },
    );
  }

  ElevatedButton _drawAddTypeButton() {
    final typeController = TextEditingController();
    return ElevatedButton(
        onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextField(
                            controller: typeController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'type',
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Delete'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  insertType(MemoType(title: typeController.text));
                                  Navigator.pop(context);
                                });
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  ),
                )),
        child: const Icon(Icons.add));
  }

  FutureBuilder<List<MemoType>> _drawTypes() {
    return FutureBuilder<List<MemoType>>(
      future: Future<List<MemoType>>(() => listType()),
      builder: (BuildContext context, AsyncSnapshot<List<MemoType>> snapshot) {
        if (snapshot.hasData) {
          List<Widget> typesBox = [];
          typesBox.addAll(snapshot.data!.map<ActionChip>((e) {
            return ActionChip(
              label: Text(e.title),
              backgroundColor: Colors.deepPurpleAccent,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              onPressed: () {
                setState(() {
                  selectedType = e;
                });
              },
            );
          }));
          typesBox.add(_drawAddTypeButton());
          return Wrap(
            children: typesBox,
          );
        }
        return Wrap(
          children: [_drawAddTypeButton()],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memo Type'),
      ),
      body: ListView(
        children: <Widget>[
          _drawTypes(),
          _drawTags(),
        ],
      ),
    );
  }
}
