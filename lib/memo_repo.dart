import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initDB() async {
  String dbPath = await getDatabasesPath();
  print(dbPath);
  return openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(dbPath, 'hs_like.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE IF NOT EXISTS memo(id INTEGER PRIMARY KEY AUTOINCREMENT, type_id INTEGER, occur_date TEXT,memo TEXT);'
        'CREATE TABLE IF NOT EXISTS type(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT);'
        'CREATE TABLE IF NOT EXISTS tag(id INTEGER PRIMARY KEY AUTOINCREMENT, type_id INTEGER, title TEXT);'
        'CREATE TABLE IF NOT EXISTS memo_tag(id INTEGER PRIMARY KEY AUTOINCREMENT, memo_id INTEGER, tag_id INTEGER);',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 2,
  );
}

Future<void> insertMemo(Memo memo) async {
  final db = await initDB();
  await db.insert('memo', memo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Memo>> listMemo() async {
  final db = await initDB();
  final List<Map<String, dynamic>> maps = await db.query('memo');
  return List.generate(maps.length, (index) {
    return Memo.full(
      id: maps[index]['id'] as int,
      typeId: maps[index]['type_id'] as int,
      occurDate: maps[index]['occur_date'] as String,
      memo: maps[index]['memo'] as String,
    );
  });
}

Future<void> updateMemo(Memo memo) async {
  final db = await initDB();
  await db.update('memo', memo.toMap(), where: 'id=?', whereArgs: [memo.id]);
}

Future<void> deleteMemo(int? id) async {
  if (id == null) {
    return;
  }
  final db = await initDB();
  await db.delete('memo', where: 'id=?', whereArgs: [id]);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var fido = Memo(typeId: 0, occurDate: '2023-11-16', memo: 'zx ky');

  await insertMemo(fido);

  List<Memo> ms = await listMemo();
  print(ms);
  print(ms[0].toMap());

  var updateM = ms[0];
  updateM.memo = 'zx ky tango unit';
  await updateMemo(updateM);

  ms = await listMemo();
  print(ms[0].toMap());

  await (deleteMemo(ms[0].id));
}

class Memo {
  int? id;
  int typeId;
  String occurDate;
  String memo;

  Memo({
    required this.typeId,
    required this.occurDate,
    required this.memo,
  });

  Memo.full({
    this.id,
    required this.typeId,
    required this.occurDate,
    required this.memo,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'type_id': typeId, 'memo': memo, 'occur_date': occurDate};
  }

  @override
  String toString() {
    return 'Memo{id: $id, typeId: $typeId, occurDate: $occurDate, memo: $memo}';
  }
}

class MemoType {
  int? id;
  String title;

  MemoType({
    required this.title,
  });

  MemoType.full({
    this.id,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title};
  }

  @override
  String toString() {
    return 'MemoType{id: $id, title: $title}';
  }
}

class Tag {
  int? id;
  int typeId;
  String title;

  Tag({
    required this.typeId,
    required this.title,
  });

  Tag.full({
    this.id,
    required this.typeId,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'type_id': typeId, 'title': title};
  }

  @override
  String toString() {
    return 'Tag{id: $id, typeId: $typeId, title: $title}';
  }
}

class MemoTag {
  int? id;
  int memoId;
  int tagId;

  MemoTag({
    required this.memoId,
    required this.tagId,
  });

  MemoTag.full({
    required this.id,
    required this.memoId,
    required this.tagId,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'memo_id': memoId, 'tag_id': tagId};
  }

  @override
  String toString() {
    return 'MemoTag{id: $id, memoId: $memoId, tagId: $tagId}';
  }
}
