import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final database = initDB();

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
        'CREATE TABLE IF NOT EXISTS memo(id INTEGER PRIMARY KEY AUTOINCREMENT, type_id INTEGER, occur_date TEXT,content TEXT);'
        'CREATE TABLE IF NOT EXISTS memo_type(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT);'
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
  final db = await database;
  int memoId = await db.insert('memo', memo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
  final List<Map<String, dynamic>> tags =
      await db.query('tag', where: 'type_id=?', whereArgs: [memo.typeId]);
  if (tags.isEmpty) {
    return;
  }
  // memo_tag
  for (var tag in tags) {
    if (memo.content.contains(tag['title'])) {
      await db.insert('memo_tag', {'memo_id': memoId, 'tag_id': tag['id']},
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }
}

Future<List<Memo>> listMemo() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('memo');
  return List.generate(maps.length, (index) {
    return Memo.full(
      id: maps[index]['id'] as int,
      typeId: maps[index]['type_id'] as int,
      occurDate: maps[index]['occur_date'] as String,
      content: maps[index]['content'] as String,
    );
  });
}

Future<void> updateMemo(Memo memo) async {
  final db = await database;
  await db.update('memo', memo.toMap(), where: 'id=?', whereArgs: [memo.id]);
  // clean memo_tag
  await db.execute('delete from memo_tag where memo_id=?', [memo.id]);
  final List<Map<String, dynamic>> tags =
      await db.query('tag', where: 'type_id=?', whereArgs: [memo.typeId]);
  if (tags.isEmpty) {
    return;
  }
  // generate memo_tag
  for (var tag in tags) {
    if (memo.content.contains(tag['title'])) {
      await db.insert('memo_tag', {'memo_id': memo.id, 'tag_id': tag['id']},
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }
}

Future<void> deleteMemo(int? id) async {
  if (id == null) {
    return;
  }
  final db = await database;
  await db.delete('memo', where: 'id=?', whereArgs: [id]);
}

Future<void> insertType(MemoType type) async {
  final db = await database;
  List<Map<String, dynamic>> exist =
      await db.query('memo_type', where: 'title=?', whereArgs: [type.title]);
  if (exist.isNotEmpty) {
    return;
  }
  await db.insert('memo_type', type.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<MemoType>> listType() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('memo_type');
  return List.generate(maps.length, (index) {
    return MemoType.full(
        id: maps[index]['id'] as int, title: maps[index]['title'] as String);
  });
}

Future<void> updateType(MemoType type) async {
  final db = await database;
  List<Map<String, dynamic>> exist =
      await db.query('memo_type', where: 'title=?', whereArgs: [type.title]);
  if (exist.isNotEmpty) {
    return;
  }
  await db
      .update('memo_type', type.toMap(), where: 'id=?', whereArgs: [type.id]);
}

Future<void> deleteType(MemoType type) async {
  final db = await database;
  List<Map<String, dynamic>> exist =
      await db.query('memo', where: 'type_id=?', whereArgs: [type.id]);
  if (exist.isNotEmpty) {
    return;
  }
  await db.delete('tag', where: 'type_id=?', whereArgs: [type.id]);
  await db.delete('memo_type', where: 'id=?', whereArgs: [type.id]);
}

Future<void> insertTag(Tag tag) async {
  final db = await database;
  List<Map<String, dynamic>> exist = await db.query('tag',
      where: 'type_id=? and title=?', whereArgs: [tag.typeId, tag.title]);
  if (exist.isNotEmpty) {
    return;
  }
  await db.insert('tag', tag.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Tag>> listTag(int typeId) async {
  final db = await database;
  final List<Map<String, dynamic>> maps =
      await db.query('tag', where: 'type_id=?', whereArgs: [typeId]);
  return List.generate(maps.length, (index) {
    return Tag.full(
        id: maps[index]['id'],
        typeId: maps[index]['type_id'],
        title: maps[index]['title']);
  });
}

class Memo {
  int? id;
  int typeId;
  String occurDate;
  String content;

  Memo({
    required this.typeId,
    required this.occurDate,
    required this.content,
  });

  Memo.full({
    this.id,
    required this.typeId,
    required this.occurDate,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type_id': typeId,
      'content': content,
      'occur_date': occurDate
    };
  }

  @override
  String toString() {
    return 'Memo{id: $id, typeId: $typeId, occurDate: $occurDate, content: $content}';
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
