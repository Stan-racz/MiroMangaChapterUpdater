import '../model/chapter_model.dart';
import '../repository/manga_db_repository.dart';

import '../locator.dart';
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

  Future<void> testTables() async {
    return await dbRepository.testTables();
  }
}
