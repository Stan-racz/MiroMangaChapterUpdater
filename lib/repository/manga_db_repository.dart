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
  Future<List<Map<String, dynamic>>> getChapterFromChapterId(String chapterId);
  Future<List<Map<String, dynamic>>> getAllMangasIds();
}

class MangaDbRepositoryImpl implements MangaDbRepository {
  static const String mangaDbName = "manga_bdd.db";
  static const String mangaTable = "Manga";
  static const String chapterTable = "Chapitre";
  static const String pagesTable = "Pages";
  static const int mangaDbVersion = 1;

  _createMangaAndChapterAndPagesTableV2(Database db) {
    db.execute('''
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
    db.execute('''
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
    db.execute('''
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
      onCreate: (db, version) async {},
      onUpgrade: (db, oldVersion, newVersion) async {},
    );

    _createMangaAndChapterAndPagesTableV2(db);

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
      where: 'mangadex_manga_id = ?',
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
          'mangadex_manga_id': page.mangadexMangaId,
        },
      );
    }
    await batch.commit(noResult: true);
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
  Future<List<Map<String, dynamic>>> getChapterFromChapterId(
      String chapterId) async {
    final db = await openDatabase(mangaDbName);
    final List<Map<String, dynamic>> chapter = await db.query(
      chapterTable,
      where: 'chapter_id = ?',
      whereArgs: [chapterId],
    );
    return chapter;
  }

  Future<List<Map<String, dynamic>>> getAllMangasIds() async {
    final db = await openDatabase(mangaDbName);
    final List<Map<String, dynamic>> mangaIds =
        await db.query(mangaTable, columns: [
      "mangadex_id",
    ]);
    return mangaIds;
  }

  @override
  Future<void> testTables() async {
    final db = await openDatabase(mangaDbName);

    final List<Map<String, Object?>> queryId =
        await db.query(mangaTable, columns: ["mangadex_id", "title"]);
    print(queryId);
    // final List<Map<String, Object?>> tables =
    //     await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");

    // final List<Map<String, Object?>> queryManga = await db.query(
    //   mangaTable,
    //   where: "title = ?",
    //   whereArgs: ["Baki Dou"],
    // );
    // print(queryManga);
    // final List<Map<String, Object?>> queryChapters = await db.query(
    //     chapterTable,
    //     where: "mangadex_manga_id = ?",
    //     whereArgs: ["c52b2ce3-7f95-469c-96b0-479524fb7a1a"]);

    // print(queryChapters);

    // final List<Map<String, Object?>> tablesStruct =
    //     await db.rawQuery("pragma table_info('$chapterTable');");

    // final List<Map<String, Object?>> queryPages = await db.query(
    //   pagesTable,
    //   // where: 'mangadex_manga_id = ?',
    //   // whereArgs: ["5439fe65-5b3a-420e-9ef4-27c9bcc49c5a"],
    // );

    // for (var element in queryChapters) {
    //   // debugPrint(element.toString());
    //   // print(queryPages);
    //   print(element);
    //   print("===============");
    // }

    // await db.delete(chapterTable, where: 'number = ?', whereArgs: ['151']);

    // await db.delete(chapterTable,
    //     where: 'chapter_id = ?',
    //     whereArgs: ['8b923a62-f4c4-4db3-ba95-c3e20806fb48']);
    // await db.delete(
    //   pagesTable,
    //   where: "chapter_id = ? ",
    //   whereArgs: ["e42eef46-2ac2-4f77-bdfa-3ce2492f0d85"],
    // );
  }
}
