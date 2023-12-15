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
      body: const Text('type-tag config'),
    );
  }
}
