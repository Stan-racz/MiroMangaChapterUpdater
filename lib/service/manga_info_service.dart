import 'dart:convert';

import 'package:dio/dio.dart';

import '../locator.dart';
import '../model/manga_model.dart';
import '../repository/mangadex_api_repository.dart';

class MangaInfoService {
  final MangaInfoRepository repository = getIt<MangaInfoRepository>();
  final dio = Dio();

  MangaInfoService();

  Future<Manga> getMangaInfoFromTitle(String title) async {
    final Response response = await repository.getMangaInfoFromTitle(title);
    final Map<String, dynamic> mangaMap = jsonDecode(response.toString());

    final Manga manga = Manga.fromJson(mangaMap);
    return manga;
  }
}
