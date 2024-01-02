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

  Widget _drawType() {
    if (selectedType == null) {
      return const Text('select none type');
    }
    final typeController = TextEditingController(text: selectedType?.title);
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
                        labelText: 'update type',
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (selectedType != null) {
                              MemoType temp = MemoType.full(
                                id: selectedType!.id,
                                title: typeController.text,
                              );
                              updateType(temp);
                            }
                            Navigator.pop(context);
                          });
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
      child: const Text('Edit Type Name'),
    );
  }

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
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            deleteTag(e.id!);
                          });
                        },
                        child: const Text('Del')),
                    _drawEditTagButton(e),
                  ],
                )
              ],
            );
          }));
          tagsBox.add(Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: _drawAddTagButton(),
          ));
          return Wrap(
            children: tagsBox,
          );
        }
        return Wrap(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: _drawAddTagButton(),
            )
          ],
        );
      },
    );
  }

  ElevatedButton _drawEditTagButton(Tag t) {
    final tagController = TextEditingController(text: t.title);
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
                            controller: tagController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'tag',
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  t.title = tagController.text;
                                  updateTag(t);
                                  Navigator.pop(context);
                                });
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
        child: const Text('Edit'));
  }

  ElevatedButton _drawAddTagButton() {
    final tagController = TextEditingController();
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
                            controller: tagController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'tag',
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (selectedType != null) {
                                    insertTag(Tag(
                                        typeId: selectedType!.id!,
                                        title: tagController.text));
                                  }
                                  Navigator.pop(context);
                                });
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
        child: const Icon(Icons.add));
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
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  insertType(
                                      MemoType(title: typeController.text));
                                  Navigator.pop(context);
                                });
                              },
                              child: const Text('Submit'),
                            ),
                          ],
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
          typesBox.addAll(snapshot.data!.map<InputChip>((e) {
            return InputChip(
              label: Text(e.title),
              selected: selectedType != null && selectedType!.id == e.id,
              onPressed: () {
                setState(() {
                  selectedType = e;
                });
              },
              onDeleted: () {
                setState(() {
                  deleteType(e);
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
          _drawType(),
          _drawTags(),
        ],
      ),
    );
  }
}
