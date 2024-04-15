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
  Future<List<Map<String, dynamic>>> getLatestChapterFromMangadexMangaId(
      String mangadexMangaId);
  Future<List<Map<String, dynamic>>> getMangaFromMangadexMangaId(
      String mangadexMangaId);
  Future<void> deleteMangaAndChapters(String mangadexMangaId);
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
                title TEXT NOT NULL,
                description TEXT NOT NULL,
                year TEXT NOT NULL,
                status TEXT NOT NULL,
                cover_id TEXT NOT NULL,
                cover_link TEXT
              );
            ''');
    await db.execute('''
              CREATE TABLE IF NOT EXISTS $chapterTable (
                chapter_id TEXT PRIMARY KEY NOT NULL,
                title TEXT NOT NULL,
                number REAL NOT NULL,
                volume TEXT NOT NULL,
                chapter_read INTEGER NOT NULL,
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
    final List<Map<String, Object?>> chapters =
        await db.query(chapterTable, orderBy: 'number DESC');
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
          'title': chapter.title,
          'number': chapter.number,
          'volume': chapter.volume,
          'chapter_read': chapter.chapterRead = 0,
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
      {'chapter_read': 1},
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
      {'chapter_read': 0},
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
  Future<List<Map<String, dynamic>>> getLatestChapterFromMangadexMangaId(
    String mangadexMangaId,
  ) async {
    final db = await openDatabase(mangaDbName);
    final List<Map<String, Object?>> chapter = await db.query(chapterTable,
        where: 'mangadex_manga_id = ?',
        whereArgs: [mangadexMangaId],
        limit: 1,
        orderBy: 'number DESC');
    return chapter;
  }

  @override
  Future<List<Map<String, dynamic>>> getMangaFromMangadexMangaId(
      String mangadexMangaId) async {
    final db = await openDatabase(mangaDbName);
    final List<Map<String, Object?>> manga = await db.query(
      mangaTable,
      where: 'mangadex_id = ?',
      whereArgs: [mangadexMangaId],
    );
    return manga;
  }

  @override
  Future<void> deleteMangaAndChapters(String mangadexMangaId) async {
    final db = await openDatabase(mangaDbName);
    await db.delete(
      mangaTable,
      where: 'mangadex_id = ?',
      whereArgs: [mangadexMangaId],
    );
    await db.delete(
      chapterTable,
      where: 'mangadex_manga_id = ?',
      whereArgs: [mangadexMangaId],
    );
  }

  @override
  Future<void> testTables() async {
    final db = await openDatabase(mangaDbName);
    final List<Map<String, Object?>> tables =
        await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
    final List<Map<String, Object?>> queryManga = await db
        .query(mangaTable, where: 'titre = ?', whereArgs: ['Baki Rahen']);
    final List<Map<String, Object?>> queryChapters =
        await db.query(chapterTable);
    final List<Map<String, Object?>> sqlVersion =
        await db.rawQuery('SELECT sqlite_version()');
    debugPrint(db.database.toString());
    debugPrint(tables.toString());
    debugPrint(sqlVersion.toString());
    for (var manga in queryManga) {
      debugPrint(manga.toString());
      debugPrint('====================================');
    }
    debugPrint("Chapters : $queryChapters");
    await db.delete(chapterTable, where: 'number = ?', whereArgs: ['1453']);
    return;
  }
}
