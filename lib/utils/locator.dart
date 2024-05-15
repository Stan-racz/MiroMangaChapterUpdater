import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:miro_manga_chapter_update/repository/manga_db_repository.dart';
import 'package:miro_manga_chapter_update/service/manga_db_service.dart';
import '../bloc/add_manga_bloc/add_manga_bloc.dart';
import '../bloc/my_mangas_bloc/my_mangas_bloc.dart';
import '../bloc/reader_bloc/reader_bloc.dart';
import '../bloc/theme_cubit/theme_cubit.dart';
import '../service/manga_info_service.dart';

import '../repository/mangadex_api_repository.dart';

final GetIt getIt = GetIt.I;

Future<void> setupLocator() async {
  getIt.registerFactory<AddMangaBloc>(() => AddMangaBloc());
  getIt.registerFactory<MyMangasBloc>(() => MyMangasBloc());
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit());
  getIt.registerFactory<ReaderBloc>(() => ReaderBloc());

  getIt.registerLazySingleton<MangaInfoService>(() => MangaInfoService());
  getIt.registerSingleton<MangaInfoRepository>(MangaInfoRepositoryImpl());
  getIt.registerSingleton<MangaDbRepository>(MangaDbRepositoryImpl());
  getIt.registerLazySingleton<MangaDbService>(() => MangaDbService());
  getIt.registerSingleton<FlutterLocalNotificationsPlugin>(
      FlutterLocalNotificationsPlugin());
}

void setupLocatorTest() {
  getIt.registerFactory<AddMangaBloc>(() => AddMangaBloc());
  getIt.registerFactory<MyMangasBloc>(() => MyMangasBloc());
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit());
  getIt.registerFactory<ReaderBloc>(() => ReaderBloc());
  getIt.registerLazySingleton<MangaInfoService>(() => MangaInfoService());
  getIt.registerSingleton<MangaInfoRepository>(MangaInfoRepositoryImpl());
  getIt.registerSingleton<MangaDbRepository>(MangaDbRepositoryImpl());
  getIt.registerLazySingleton<MangaDbService>(() => MangaDbService());
  getIt.registerSingleton<FlutterLocalNotificationsPlugin>(
      FlutterLocalNotificationsPlugin());
}
