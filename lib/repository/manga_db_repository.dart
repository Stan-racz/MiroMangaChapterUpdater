import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../model/manga_model.dart';

abstract class MangaDbRepository {
  Future<void> getTables();
  Future<int> insertManga(Manga manga);
  Future<List<Map<String, dynamic>>> getAllMangas();
  Future<void> testTables();
}

class MangaDbRepositoryImpl implements MangaDbRepository {
  static const String mangaDbName = "manga_bdd.db";
  static const String mangaTable = "Manga";
  static const String chapitreTable = "Chapitre";
  static const int mangaDbVersion = 1;

  Database? db;

  @override
  Future<Database> getTables() async {
    final db = await openDatabase(
      mangaDbName,
      version: mangaDbVersion,
    );

    await db.execute('''
              CREATE TABLE IF NOT EXISTS $mangaTable (
                mangadex_id TEXT PRIMARY KEY NOT NULL,
                titre TEXT NOT NULL,
                description TEXT NOT NULL,
                annee TEXT NOT NULL,
                status TEXT NOT NULL
              );
            ''');
    await db.execute('''
              CREATE TABLE IF NOT EXISTS $chapitreTable (
                chapter_id TEXT PRIMARY KEY NOT NULL,
                titre TEXT NOT NULL,
                number TEXT NOT NULL,
                volume TEXT NOT NULL,
                chapitre_lu INTEGER NOT NULL,
                mangadex_manga_id INTEGER,
                FOREIGN KEY (mangadex_manga_id) REFERENCES Manga (mangadex_id)
              );
              ''');
    return db;
  }

  @override
  Future<int> insertManga(Manga manga) async {
    final db = await openDatabase(mangaDbName);
    int status = await db.insert(
      mangaTable,
      manga.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    return status;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllMangas() async {
    final db = await openDatabase(mangaDbName);
    final List<Map<String, Object?>> mangas = await db.query(mangaTable);
    return mangas;
  }

  @override
  Future<void> testTables() async {
    final db = await openDatabase(mangaDbName);
    final List<Map<String, Object?>> tables =
        await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
    final List<Map<String, Object?>> query = await db.query("Manga");
    final List<Map<String, Object?>> sqlVersion =
        await db.rawQuery('SELECT sqlite_version()');
    debugPrint(db.database.toString());
    debugPrint(tables.toString());
    debugPrint(sqlVersion.toString());
    debugPrint("Mangas : $query");
    return;
  }
}
