import 'package:get_it/get_it.dart';
import 'service/manga_info_service.dart';

import 'repository/mangadex_api_repository.dart';

final GetIt getIt = GetIt.I;

void setupLocator() {
  getIt.registerLazySingleton<MangaInfoService>(() => MangaInfoService());
  getIt.registerSingleton<MangaInfoRepository>(MangaInfoRepositoryImpl());
}
