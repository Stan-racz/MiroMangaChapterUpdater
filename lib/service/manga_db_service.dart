import '../model/chapter_model.dart';
import '../repository/manga_db_repository.dart';

import '../locator.dart';
import '../model/manga_model.dart';

class MangaDbService {
  final MangaDbRepository repository = getIt<MangaDbRepository>();

  MangaDbService();

  Future<List<Manga>> getAllMangas() async {
    final List<Map<String, dynamic>> mangas = await repository.getAllMangas();
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
        await repository.getAllChapters();
    List<Chapter> chapterList = [];
    for (Map<String, dynamic> chapter in chapters) {
      chapterList.add(
        Chapter.fromDb(chapter),
      );
    }
    return chapterList;
  }

  Future<int> insertManga(Manga manga) async {
    final int mangaInsertStatus = await repository.insertManga(manga);
    return mangaInsertStatus;
  }

  Future<void> updateBatchMangaChapters(List<Chapter> chapterList) async {
    await repository.insertChapters(chapterList);
    return;
  }

  Future<void> createTables() async {
    repository.getTables();
  }

  Future<void> testTables() {
    return repository.testTables();
  }
}
