import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../models/note_model.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DBHelper {
  static Database? _db;

  addData() async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'new_data_added',
    );
  }

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "notes.db");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, age INTEGER, description TEXT, email TEXT)");
  }

  Future<NotesModel> insert(NotesModel note) async {
    var dbClient = await db;
    await dbClient!.insert("Notes", note.toMap());
    addData();
    return note;
  }

  Future<List<NotesModel>> getNotes() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query("Notes");

    return queryResult.map((e) => NotesModel.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete("Notes", where: "id = ?", whereArgs: [id]);
  }

  Future update(NotesModel notes) async {
    var dbClient = await db;

    return await dbClient!.update(
      "notes",
      notes.toMap(),
      where: "id = ?",
      whereArgs: [notes.id],
    );
  }
}
