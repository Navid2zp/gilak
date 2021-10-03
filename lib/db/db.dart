import 'dart:io';
import 'package:sqflite/sqflite.dart';

import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:gilak/models/word.dart';

class DB {
  static Database _database;

  Future<Database> get database async {
    if (_database == null || !_database.isOpen) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future copyDatabase(String path) async {
    ByteData data = await rootBundle.load("assets/dictionary.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes, flush: true);
  }

  Future<Database> initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = databasesPath + "/dictionary.db";
    // print(path);
    // ByteData data = await rootBundle.load("assets/dictionary.db");
    // var file = File(path);
    // print(await file.length());

    // Get the directory path for both Android and iOS to store database.
    var exists = await databaseExists(path);
    if (!exists) {
      await copyDatabase(path);
    }

    // String path = directory.path + 'dictionary.db';

    // Open/create the database at a given path

    // var data =
    //     await _database.rawQuery('SELECT word FROM dictionary WHERE id = 50;');
    // print(data);
    _database = await openDatabase(path, version: 1);
    return _database;
  }

  Future closeDB() async {
    if (_database != null) {
      await _database.close();
    }
  }

  Future<List<Word>> searchWords(String search) async {
    Database db = await this.database;
    List<Word> words = List<Word>();
    // var words = new List<Word>;
    var results = await db.rawQuery(
        "select * from dictionary where word like '%$search%' limit 10");
    results.forEach((result) {
      var word = Word(
          id: result["id"], word: result["word"], meaning: result["meaning"]);
      words.add(word);
    });

    return words;
  }

  Future<Word> randomWord() async {
    Database db = await this.database;
    var word = Word();
    // var words = new List<Word>;
    var results =
        await db.rawQuery("select * from dictionary order by random() limit 1");
    results.forEach((result) {
      word.id = result["id"];
      word.meaning = result["meaning"];
      word.word = result["word"];
    });

    return word;
  }

  Future<List<String>> getAlphabets() async {
    Database db = await this.database;
    var alphabets = List<String>();
    // var words = new List<Word>;
    var results = await db.rawQuery(
        "select distinct substr(word, 1, 1) as alphabet from dictionary");
    results.forEach((result) {
      alphabets.add(result["alphabet"]);
    });

    return alphabets;
  }

  Future<List<Word>> getWords(String alphabet) async {
    Database db = await this.database;
    List<Word> words = List<Word>();
    var results = await db.rawQuery(
        "select * from dictionary where substr(word, 1, 1) like '$alphabet'");
    results.forEach((result) {
      var word = Word(
          id: result["id"], word: result["word"], meaning: result["meaning"]);
      words.add(word);
    });

    return words;
  }
}
