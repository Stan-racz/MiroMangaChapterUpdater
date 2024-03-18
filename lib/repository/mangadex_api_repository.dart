import 'package:dio/dio.dart';
import '../api_path.dart';

abstract class MangaInfoRepository {
  Future<dynamic> getMangaInfoFromTitle(String title);
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
}
