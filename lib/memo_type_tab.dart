import 'package:flutter/material.dart';

class MemoTypeTab extends StatefulWidget {
  const MemoTypeTab({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MemoTypeTabState();
  }
}

class _MemoTypeTabState extends State<MemoTypeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memo Type'),
      ),
      body: ListView(
        children: <Widget>[
          Wrap(
            children: [
              const Chip(
                label: Text('公演'),
                backgroundColor: Colors.deepPurpleAccent,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),
              const Chip(
                label: Text('抖音'),
                backgroundColor: Colors.deepPurpleAccent,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),
              const Chip(
                label: Text('小红书'),
                backgroundColor: Colors.deepPurpleAccent,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),
              const Chip(
                label: Text('微博'),
                backgroundColor: Colors.deepPurpleAccent,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),
              ElevatedButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text('This is a typical dialog.'),
                                  const SizedBox(height: 15),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              ),
                            ),
                          )),
                  child: const Icon(Icons.add)),
            ],
          ),
          Wrap(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('mc2'),
                  Wrap(
                    children: [
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Del')),
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Edit')),
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
