import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:miro_manga_chapter_update/repository/manga_db_repository.dart';
import 'package:miro_manga_chapter_update/service/manga_db_service.dart';
import 'service/manga_info_service.dart';

import 'repository/mangadex_api_repository.dart';

final GetIt getIt = GetIt.I;

void setupLocator() {
  getIt.registerLazySingleton<MangaInfoService>(() => MangaInfoService());
  getIt.registerSingleton<MangaInfoRepository>(MangaInfoRepositoryImpl());
  getIt.registerSingleton<MangaDbRepository>(MangaDbRepositoryImpl());
  getIt.registerLazySingleton<MangaDbService>(() => MangaDbService());
  getIt.registerSingleton<FlutterLocalNotificationsPlugin>(
      FlutterLocalNotificationsPlugin());
}
