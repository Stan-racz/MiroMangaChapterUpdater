import 'dart:convert';

import 'package:miro_manga_chapter_update/repository/manga_db_repository.dart';

import '../locator.dart';
import '../model/manga_model.dart';

class MangaDbService {
  final MangaDbRepository repository = getIt<MangaDbRepository>();

  MangaDbService();

  Future<Manga> getAllMangas() async {
    final List<Map<String, dynamic>> mangas = await repository.getAllMangas();
    final Map<String, dynamic> mangaMap = jsonDecode(mangas.toString());

    final Manga manga = Manga.fromJson(mangaMap);
    return manga;
  }

  Future<int> insertManga(Manga manga) async {
    final int mangaInsertStatus = await repository.insertManga(manga);
    return mangaInsertStatus;
  }

  Future<void> createTables() async {
    repository.getTables();
  }

  Future<void> testTables() {
    return repository.testTables();
  }
}
