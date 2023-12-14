import 'package:flutter/material.dart';

class MemoTab extends StatelessWidget {
  const MemoTab({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: ListView(
      children: const <Widget>[
        Text('yyyy-MM-dd'),
        Text('stage'),
        Text('platform'),
        Text('desc'),
      ],
    ));
  }
}
