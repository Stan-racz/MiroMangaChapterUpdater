import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:miro_manga_chapter_update/repository/manga_db_repository.dart';

import '../locator.dart';
import '../model/chapter_model.dart';
import '../model/manga_model.dart';
import '../repository/mangadex_api_repository.dart';

class MangaInfoService {
  final MangaInfoRepository repository = getIt<MangaInfoRepository>();
  final MangaDbRepository dbRepository = getIt<MangaDbRepository>();
  final dio = Dio();

  MangaInfoService();

  Future<Manga> getMangaInfoFromTitle(String title) async {
    final Response response = await repository.getMangaInfoFromTitle(title);
    final Map<String, dynamic> mangaMap = jsonDecode(response.toString());

    final Manga manga = Manga.fromJson(mangaMap);
    return manga;
  }

  /// For a given mangadexMangaId, goes and search the last 10 english translated chapters
  /// of the mangadexMangaId, and saves them in the DB at the correct manga.
  Future<List<Chapter>> getMangaChaptersFromMangaId(
      String mangadexMangaId) async {
    final Response response =
        await repository.getMangaChaptersFromMangaId(mangadexMangaId);

    List<dynamic> responseMapList = response.data['data'];

    List<Chapter> chapters = [];
    for (var element in responseMapList) {
      chapters.add(Chapter.fromJson(element));
    }

    return chapters;
  }
}
