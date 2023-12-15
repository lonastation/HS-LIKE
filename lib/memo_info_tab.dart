import 'package:flutter/material.dart';

class MemoInfoTab extends StatefulWidget {
  const MemoInfoTab({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MemoInfoTabState();
  }
}

class _MemoInfoTabState extends State<MemoInfoTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memo Detail'),
      ),
      body: const Center(
        child: Text('memo info'),
      ),
    );
  }
}
