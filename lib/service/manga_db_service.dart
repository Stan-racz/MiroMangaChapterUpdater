import '../model/chapter_model.dart';
import '../model/pages_model.dart';
import '../repository/manga_db_repository.dart';

import '../utils/locator.dart';
import '../model/manga_model.dart';

class MangaDbService {
  final MangaDbRepository dbRepository = getIt<MangaDbRepository>();

  MangaDbService();

  Future<List<Manga>> getAllMangas() async {
    final List<Map<String, dynamic>> mangas = await dbRepository.getAllMangas();
    List<Manga> mangaList = [];
    for (Map<String, dynamic> manga in mangas) {
      mangaList.add(
        Manga.fromDb(manga),
      );
    }
    return mangaList;
  }

  Future<List<Chapter>> getAllChapters() async {
    final List<Map<String, dynamic>> chapters =
        await dbRepository.getAllChapters();
    List<Chapter> chapterList = [];
    for (Map<String, dynamic> chapter in chapters) {
      chapterList.add(
        Chapter.fromDb(chapter),
      );
    }
    return chapterList;
  }

  Future<List<Chapter>> getLatestChapter(String mangadexMangaId) async {
    final List<Map<String, dynamic>> chapters =
        await dbRepository.getLatestChapterFromMangadexMangaId(mangadexMangaId);

    List<Chapter> chapterList = [];
    for (Map<String, dynamic> chapter in chapters) {
      chapterList.add(
        Chapter.fromDb(chapter),
      );
    }
    return chapterList;
  }

  Future<void> updateCoverLink(String coverLink, String mangadexMangaId) async {
    return await dbRepository.updateCoverLink(coverLink, mangadexMangaId);
  }

  Future<int> insertManga(Manga manga) async {
    final int mangaInsertStatus = await dbRepository.insertManga(manga);
    return mangaInsertStatus;
  }

  Future<void> insertBatchMangaChapters(List<Chapter> chapterList) async {
    await dbRepository.insertChapters(chapterList);
    return;
  }

  Future<void> insertBatchPages(List<Pages> pageList) async {
    await dbRepository.insertBatchPages(pageList);
    return;
  }

  Future<void> createTables() async {
    dbRepository.getTables();
  }

  Future<void> updateChapterRead(String chapterId) async {
    await dbRepository.updateChapterRead(chapterId);
  }

  Future<void> updateChapterUnread(String chapterId) async {
    await dbRepository.updateChapterUnread(chapterId);
  }

  Future<List<Manga>> getMangaFromMangadexMangaId(
      String mangadexMangaId) async {
    final List<Map<String, dynamic>> mangas =
        await dbRepository.getMangaFromMangadexMangaId(mangadexMangaId);
    List<Manga> mangaList = [];
    for (Map<String, dynamic> manga in mangas) {
      mangaList.add(
        Manga.fromDb(manga),
      );
    }
    return mangaList;
  }

  Future<void> deleteMangaAndChapters(String mangadexMangaId) async {
    await dbRepository.deleteMangaAndChapters(mangadexMangaId);
  }

  Future<List<Pages>> getPagesFromChapterId(String chapterId) async {
    final List<Map<String, dynamic>> pages =
        await dbRepository.getPagesFromChapterId(chapterId);
    List<Pages> pageList = [];
    for (Map<String, dynamic> page in pages) {
      pageList.add(
        Pages.fromDb(page),
      );
    }
    return pageList;
  }

  Future<Chapter> getChapterFromChapterId(String chapterId) async {
    final List<Map<String, dynamic>> chapters =
        await dbRepository.getChapterFromChapterId(chapterId);
    List<Chapter> chapterList = [];
    for (Map<String, dynamic> chapter in chapters) {
      chapterList.add(
        Chapter.fromDb(chapter),
      );
    }
    return chapterList.first;
  }

  Future<List<String>> getAllMangasIds() async {
    final List<Map<String, dynamic>> mangaIds =
        await dbRepository.getAllMangasIds();
    List<String> mangaIdsList = [];
    for (var id in mangaIds) {
      mangaIdsList.add(id.values.single);
    }
    return mangaIdsList;
  }

  Future<void> testTables() async {
    return await dbRepository.testTables();
  }
}
