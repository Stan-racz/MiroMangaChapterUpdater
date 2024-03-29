import 'package:dio/dio.dart';
import '../api_path.dart';

abstract class MangaInfoRepository {
  Future<Response> getMangaInfoFromTitle(String title);
  Future<Response> getMangaChaptersFromMangaId(String mangadexMangaId);
}

class MangaInfoRepositoryImpl implements MangaInfoRepository {
  final dio = Dio();

  @override
  Future<Response> getMangaInfoFromTitle(String title) async {
    final response = await dio.get(
      getMangaInfoFromTitlePath(title),
    );
    return response;
  }

  @override
  Future<Response> getMangaChaptersFromMangaId(String mangadexMangaId) async {
    final response = await dio.get(
      getMangaChaptersFromMangaIdPath(mangadexMangaId),
    );
    return response;
  }
}
