import 'dart:convert';

import 'package:dio/dio.dart';

import '../locator.dart';
import '../model/chapter_model.dart';
import '../model/cover_model.dart';
import '../model/manga_model.dart';
import '../repository/manga_db_repository.dart';
import '../repository/mangadex_api_repository.dart';

class MangaInfoService {
  final MangaInfoRepository repository = getIt<MangaInfoRepository>();
  final MangaDbRepository dbRepository = getIt<MangaDbRepository>();
  final dio = Dio();

  MangaInfoService();

  ///From a title search on the Manga API, retrieve a list of mangas in response =>
  ///the response is then transformed in MangaAPI object.
  ///This object contains a lot of data that I don't necessarily use
  ///so it is transformed in a lighter Manga object that contains the
  ///info I need so far that is then returned.
  Future<List<Manga>> getMangaInfoFromTitle(String title) async {
    final Response response = await repository.getMangaInfoFromTitle(title);
    final Map<String, dynamic> mangaMap = jsonDecode(response.toString());
    final MangaApi mangaApi = MangaApi.fromJson(mangaMap);
    List<Manga> mangasFound = [];
    String coverId = "";
    if (mangaApi.data != null) {
      for (var data in mangaApi.data!) {
        for (var relationship in data.relationships!) {
          if (relationship.type == "cover_art") {
            coverId = relationship.id!;
          }
        }
        final Manga manga = Manga(
          mangadexId: data.id ?? "",
          titre: data.attributes?.title?.en ?? "",
          description: data.attributes?.description?.en ?? "",
          annee: data.attributes?.year.toString() ?? "",
          status: data.attributes?.status ?? "",
          coverId: coverId,
        );
        mangasFound.add(manga);
      }
    }
    return mangasFound;
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

  Future<Cover> getCoverFromCoverId(String coverId) async {
    final Response response = await repository.getCoverFromCoverId(coverId);
    final Map<String, dynamic> coverMap = jsonDecode(response.toString());
    final Cover cover = Cover.fromJson(coverMap);
    return cover;
  }
}
