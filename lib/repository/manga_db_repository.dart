import 'package:sqflite/sqflite.dart';

import '../model/chapter_model.dart';
import '../model/manga_model.dart';
import '../model/pages_model.dart';

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
  Future<void> insertBatchPages(List<Pages> pageList);
  Future<List<Map<String, dynamic>>> getPagesFromChapterId(String chapterId);
}

class MangaDbRepositoryImpl implements MangaDbRepository {
  static const String mangaDbName = "manga_bdd.db";
  static const String mangaTable = "Manga";
  static const String chapterTable = "Chapitre";
  static const String pagesTable = "Pages";
  static const int mangaDbVersion = 1;

  Database? db;

  _upgradeMangaTableV2(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS $mangaTable');
    batch.execute('''
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
  }

  _upgradeChapterTableV2(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS $chapterTable');
    batch.execute('''
              CREATE TABLE IF NOT EXISTS $chapterTable (
                chapter_id TEXT PRIMARY KEY NOT NULL,
                title TEXT NOT NULL,
                number REAL NOT NULL,
                volume TEXT NOT NULL,
                chapter_read INTEGER NOT NULL,
                mangadex_manga_id INTEGER,
                pages INTEGER NOT NULL,
                external_url TEXT,
                FOREIGN KEY (mangadex_manga_id) REFERENCES Manga (mangadex_id)
              );
              ''');
  }

  _upgradePageTableV2(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS $mangaTable');
    batch.execute('''
              CREATE TABLE IF NOT EXISTS $pagesTable (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                chapter_id TEXT  NOT NULL,
                hash TEXT NOT NULL,
                data REAL NOT NULL,
                mangadex_manga_id INTEGER,
                FOREIGN KEY (mangadex_manga_id) REFERENCES Manga (mangadex_id)
              );
              ''');
  }

  _createMangaAndChapterAndPagesTableV2(Batch batch) {
    batch.execute('''
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
    batch.execute('''
              CREATE TABLE IF NOT EXISTS $chapterTable (
                chapter_id TEXT PRIMARY KEY NOT NULL,
                title TEXT NOT NULL,
                number REAL NOT NULL,
                volume TEXT NOT NULL,
                chapter_read INTEGER NOT NULL,
                mangadex_manga_id INTEGER,
                pages INTEGER NOT NULL,
                external_url TEXT,
                FOREIGN KEY (mangadex_manga_id) REFERENCES Manga (mangadex_id)
              );
              ''');
    batch.execute('''
              CREATE TABLE IF NOT EXISTS $pagesTable (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                chapter_id TEXT  NOT NULL,
                hash TEXT NOT NULL,
                data REAL NOT NULL,
                mangadex_manga_id INTEGER,
                FOREIGN KEY (mangadex_manga_id) REFERENCES Manga (mangadex_id)
              );
              ''');
  }

  @override
  Future<Database> getTables() async {
    final db = await openDatabase(
      mangaDbName,
      version: 2,
      onCreate: (db, version) async {
        var batch = db.batch();
        _createMangaAndChapterAndPagesTableV2(batch);
        await batch.commit();
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        var batch = db.batch();
        _upgradeMangaTableV2(batch);
        _upgradeChapterTableV2(batch);
        _upgradePageTableV2(batch);
        await batch.commit();
      },
    );
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
    for (Chapter chapter in chapterList) {
      batch.insert(
        chapterTable,
        {
          'chapter_id': chapter.chapterId,
          'title': chapter.title,
          'number': chapter.number,
          'volume': chapter.volume,
          'chapter_read': chapter.chapterRead = 0,
          'mangadex_manga_id': chapter.mangadexMangaId,
          'pages': chapter.pages,
          'external_url': chapter.externalUrl,
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
    await db.delete(
      pagesTable,
      where: 'chapter_id = ?',
      whereArgs: [mangadexMangaId],
    );
  }

  @override
  Future<void> insertBatchPages(List<Pages> pageList) async {
    final db = await openDatabase(mangaDbName);
    final Batch batch = db.batch();
    for (Pages page in pageList) {
      batch.insert(
        pagesTable,
        {
          'chapter_id': page.chapterId,
          'hash': page.hash,
          'data': page.data,
          'mangadex_manga_id': page.chapterId,
        },
        // conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      if (batch.length == 50) {
        await batch.commit(noResult: true);
      }
    }
    return;
  }

  @override
  Future<List<Map<String, dynamic>>> getPagesFromChapterId(
      String chapterId) async {
    final db = await openDatabase(mangaDbName);
    final List<Map<String, dynamic>> pages = await db.query(
      pagesTable,
      where: 'chapter_id = ?',
      whereArgs: [chapterId],
    );
    return pages;
  }

  @override
  Future<void> testTables() async {
    // final db = await openDatabase(mangaDbName);
    // final List<Map<String, Object?>> tables =
    //     await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");

    // final List<Map<String, Object?>> queryManga = await db.query(mangaTable);
    // final List<Map<String, Object?>> queryChapters =
    //     await db.query(chapterTable);

    // final List<Map<String, Object?>> tablesStruct =
    //     await db.rawQuery("pragma table_info('$chapterTable');");

    // final List<Map<String, Object?>> queryPages = await db.query(
    //   pagesTable,
    //   // where: 'chapter_id = ?',
    //   // whereArgs: ["79ec2ae8-149d-4e5a-92ff-8166e05f473e"],
    // );

    // final List<Map<String, Object?>> sqlVersion =
    //     await db.rawQuery('SELECT sqlite_version()');

    // debugPrint(db.database.toString());

    // debugPrint(tablesStruct.toString());

    // debugPrint(sqlVersion.toString());

    // for (var manga in queryManga) {
    //   debugPrint(manga.toString());
    //   debugPrint('====================================');
    // }

    // debugPrint("Chapters : $queryChapters");79ec2ae8-149d-4e5a-92ff-8166e05f473e

    // debugPrint("Chapters : $queryChapters");

    // for (var element in queryChapters) {
    //   print(element);
    // }

    // for (var element in queryPages) {
    //   print(element);
    // }

    // debugPrint("Pages : $queryPages");
    // await db.delete(chapterTable, where: 'number = ?', whereArgs: ['1453']);
  }
}
