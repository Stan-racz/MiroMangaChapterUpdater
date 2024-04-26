import 'package:dio/dio.dart';
import '../api_path.dart';

abstract class MangaInfoRepository {
  Future<Response> getMangaInfoFromTitle(String title);
  Future<Response> getMangaChaptersFromMangaId(String mangadexMangaId);
  Future<Response> getCoverFromCoverId(String coverId);
  Future<Response> getChapterHashAndPages(String chapterId);
}

class MangaInfoRepositoryImpl implements MangaInfoRepository {
  final dio = Dio();

  @override
  Future<Response> getMangaInfoFromTitle(String title) async {
    final Response response = await dio.get(
      getMangaInfoFromTitlePath(title),
    );
    return response;
  }

  @override
  Future<Response> getMangaChaptersFromMangaId(String mangadexMangaId) async {
    final Response response = await dio.get(
      getMangaChaptersFromMangaIdPath(mangadexMangaId),
    );
    return response;
  }

  @override
  Future<Response> getCoverFromCoverId(String coverId) async {
    final Response response = await dio.get(getCoverLinkFromCoverId(coverId));
    return response;
  }

  @override
  Future<Response> getChapterHashAndPages(String chapterId) async {
    final Response response =
        await dio.get(getChapterHashAndPagesPath(chapterId));
    return response;
  }
}
