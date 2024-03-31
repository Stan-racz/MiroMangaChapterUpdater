import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../model/chapter_model.dart';
import '../model/manga_model.dart';

abstract class MangaDbRepository {
  Future<void> getTables();
  Future<int> insertManga(Manga manga);
  Future<List<Map<String, dynamic>>> getAllMangas();
  Future<List<Map<String, dynamic>>> getAllChapters();
  Future<void> testTables();
  Future<void> updateChapterRead(String chapterId);
  Future<void> updateChapterUnread(String chapterId);
  Future<void> insertChapters(List<Chapter> chapterList);
  Future<void> updateCoverLink(String coverLink, String mangadexMangaId);
}

class MangaDbRepositoryImpl implements MangaDbRepository {
  static const String mangaDbName = "manga_bdd.db";
  static const String mangaTable = "Manga";
  static const String chapterTable = "Chapitre";
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
                status TEXT NOT NULL,
                cover_id TEXT NOT NULL,
                cover_link TEXT
              );
            ''');
    await db.execute('''
              CREATE TABLE IF NOT EXISTS $chapterTable (
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
  Future<List<Map<String, dynamic>>> getAllChapters() async {
    final db = await openDatabase(mangaDbName);
    final List<Map<String, Object?>> chapters = await db.query(chapterTable);
    return chapters;
  }

  @override
  Future<void> insertChapters(List<Chapter> chapterList) async {
    final db = await openDatabase(mangaDbName);
    final Batch batch = db.batch();
    for (var chapter in chapterList) {
      batch.insert(
        chapterTable,
        {
          'chapter_id': chapter.chapterId,
          'titre': chapter.titre,
          'number': chapter.number,
          'volume': chapter.volume,
          'chapitre_lu': chapter.chapitreLu = 0,
          'mangadex_manga_id': chapter.mangadexMangaId,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
    await batch.commit(noResult: true);
    return;
  }

  @override
  Future<void> updateChapterRead(String chapterId) async {
    final db = await openDatabase(mangaDbName);
    await db.update(
      chapterTable,
      {'chapitre_lu': 1},
      where: 'chapter_id = ?',
      whereArgs: [chapterId],
    );
    return;
  }

  @override
  Future<void> updateChapterUnread(String chapterId) async {
    final db = await openDatabase(mangaDbName);
    await db.update(
      chapterTable,
      {'chapitre_lu': 0},
      where: 'chapter_id = ?',
      whereArgs: [chapterId],
    );
  }

  @override
  Future<void> updateCoverLink(String coverLink, String mangadexMangaId) async {
    final db = await openDatabase(mangaDbName);
    await db.update(
      mangaTable,
      {'cover_link': coverLink},
      where: 'mangadex_id = ?',
      whereArgs: [mangadexMangaId],
    );
    return;
  }

  @override
  Future<void> testTables() async {
    final db = await openDatabase(mangaDbName);
    final List<Map<String, Object?>> tables =
        await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
    final List<Map<String, Object?>> queryManga = await db.query(mangaTable);
    final List<Map<String, Object?>> queryChapters =
        await db.query(chapterTable);
    final List<Map<String, Object?>> sqlVersion =
        await db.rawQuery('SELECT sqlite_version()');
    debugPrint(db.database.toString());
    debugPrint(tables.toString());
    debugPrint(sqlVersion.toString());
    debugPrint("Mangas : $queryManga");
    debugPrint("Chapters : $queryChapters");
    return;
  }
}
