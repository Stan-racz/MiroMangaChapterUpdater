import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro_manga_chapter_update/notifications/notifications.dart';

import '../../utils/locator.dart';
import '../../model/chapter_model.dart';
import '../../model/cover_model.dart';
import '../../model/manga_model.dart';
import '../../model/pages_model.dart';
import '../../service/manga_db_service.dart';
import '../../service/manga_info_service.dart';
import 'my_mangas_event.dart';
import 'my_mangas_state.dart';

class MyMangasBloc extends Bloc<MyMangasEvent, MyMangasState> {
  MyMangasBloc() : super(MyMangasInitial()) {
    on<GetAllMangasFromDbEvent>(_getAllMangasFromDb);
    on<GetAllMangasChaptersEvent>(_getMangaChaptersFromApiAndInsertInDb);
    on<GetAllMangasCoverLinksEvent>(_getAllMangaCoverLinks);
    on<MyMangasChapterReadEvent>(_chapterRead);
    on<CheckForNewMangaChaptersEvent>(_checkForNewChaptersAndNotifyUser);
    on<MyMangasTestEvent>(_test);
    on<DeleteMangaEvent>(_deleteManga);
  }

  final MangaInfoService mangaInfoService = getIt<MangaInfoService>();
  final MangaDbService mangaDbService = getIt<MangaDbService>();

  void _getAllMangasFromDb(
    GetAllMangasFromDbEvent event,
    Emitter<MyMangasState> emit,
  ) async {
    try {
      List<Manga> userMangas = await mangaDbService.getAllMangas();
      List<Chapter> userMangasChapters = await mangaDbService.getAllChapters();
      if (userMangasChapters.isNotEmpty) {
        emit(
          MyMangasRetrivedWithChaptersFromDb(
            userMangaChapterList: userMangasChapters,
            userMangaList: userMangas,
          ),
        );
      } else {
        emit(
          MyMangasRetrivedFromDb(userMangaList: userMangas),
        );
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void _getMangaChaptersFromApiAndInsertInDb(
    GetAllMangasChaptersEvent event,
    Emitter<MyMangasState> emit,
  ) async {
    try {
      //je récupère tous les mangas de ma DB
      List<Manga> userMangas = await mangaDbService.getAllMangas();
      //Je crée une liste avec tous les ids de ces mangas
      List<String> userMangasId = [];
      for (Manga manga in userMangas) {
        userMangasId.add(manga.mangadexId);
      }
      //je crée une liste d'objets chapters
      List<Chapter> chapterList = [];
      //pour tous les ids de mangas dans ma liste, je récupère les 10
      //derniers chapitres, je les sauvegardes dans la DB puis je les passe
      for (var id in userMangasId) {
        chapterList
            .addAll(await mangaInfoService.getMangaChaptersFromMangaId(id));
      }
      await mangaDbService.insertBatchMangaChapters(chapterList);
      List<Chapter> dbChapterList = await mangaDbService.getAllChapters();
      emit(MyMangasRetrivedWithChaptersFromDb(
          userMangaList: userMangas, userMangaChapterList: dbChapterList));
    } catch (error) {
      debugPrint("_getMangaChaptersFromAPI error : ${error.toString()}");
    }
  }

  void _getAllMangaCoverLinks(
    GetAllMangasCoverLinksEvent event,
    Emitter<MyMangasState> emit,
  ) async {
    List<Manga> userMangas = await mangaDbService.getAllMangas();

    for (var manga in userMangas) {
      if (manga.coverId != null && manga.coverLink == null) {
        Cover cover =
            await mangaInfoService.getCoverFromCoverId(manga.coverId!);
        String coverLink =
            "https://mangadex.org/covers/${manga.mangadexId}/${cover.data?.attributes?.fileName}";
        await mangaDbService.updateCoverLink(coverLink, manga.mangadexId);
      }
    }
  }

  void _chapterRead(
    MyMangasChapterReadEvent event,
    Emitter<MyMangasState> emit,
  ) async {
    if (event.chapterRead == true) {
      await mangaDbService.updateChapterUnread(event.chapterId);
    } else {
      await mangaDbService.updateChapterRead(event.chapterId);
    }
    List<Manga> userMangas = await mangaDbService.getAllMangas();
    List<Chapter> userMangasChapters = await mangaDbService.getAllChapters();
    emit(
      MyMangasRetrivedWithChaptersFromDb(
        userMangaChapterList: userMangasChapters,
        userMangaList: userMangas,
      ),
    );
  }

  void _checkForNewChaptersAndNotifyUser(
    CheckForNewMangaChaptersEvent event,
    Emitter<MyMangasState> emit,
  ) async {
    AndroidNotif androidNotif = AndroidNotif();
    List<Chapter> apiChapterList = [];
    List<Chapter> dbChapterList = [];
    List<Chapter> chaptersToInsertInDb = [];
    List<String> mangaIdToNotify = [];
    List<Manga> mangaToNotify = [];
    List<Pages> pageListToInsertInDb = [];

    List<Manga> userMangas = await mangaDbService.getAllMangas();

    List<String> userMangasId = [];
    for (Manga manga in userMangas) {
      userMangasId.add(manga.mangadexId);
    }

    try {
      for (var id in userMangasId) {
        dbChapterList.addAll(await mangaDbService.getLatestChapter(id));
        apiChapterList
            .addAll(await mangaInfoService.getMangaChaptersFromMangaId(id));
      }

      for (Chapter chapter in dbChapterList) {
        for (Chapter apiChapter in apiChapterList) {
          if (chapter.mangadexMangaId == apiChapter.mangadexMangaId) {
            if (chapter.number < apiChapter.number) {
              chaptersToInsertInDb.add(apiChapter);
              if (apiChapter.pages != 0) {
                pageListToInsertInDb.addAll(
                  await mangaInfoService.getPagesOfChapterFromApi(
                    chapterId: apiChapter.chapterId,
                    mangadexMangaId: apiChapter.mangadexMangaId,
                  ),
                );
              }
              if (!mangaIdToNotify.contains(apiChapter.mangadexMangaId)) {
                mangaIdToNotify.add(apiChapter.mangadexMangaId);
              }
            }
          }
        }
      }

      await mangaDbService.insertBatchMangaChapters(chaptersToInsertInDb);
      await mangaDbService.insertBatchPages(pageListToInsertInDb);

      for (String id in mangaIdToNotify) {
        mangaToNotify
            .addAll(await mangaDbService.getMangaFromMangadexMangaId(id));
      }

      for (Manga manga in mangaToNotify) {
        ReceivedNotification notification = ReceivedNotification(
          id: DateTime.now().millisecond,
          title: "Miro Manga Chapter Updater",
          body: "Nouveau chapitre de ${manga.titre}",
          payload: "payload",
        );
        androidNotif.showNotification(notification,
            androidNotif.getNewChapterNoSoundPlatformChannelDetails());
        sleep(const Duration(seconds: 2));
      }

      dbChapterList = await mangaDbService.getAllChapters();
      emit(MyMangasRetrivedWithChaptersFromDb(
          userMangaList: userMangas, userMangaChapterList: dbChapterList));
    } on Exception catch (e) {
      if (e.toString().contains("503")) {
        emit(MangadexDown());
      }
      emit(MyMangasState());
    }
  }

  void _deleteManga(
    DeleteMangaEvent event,
    Emitter<MyMangasState> emit,
  ) async {
    await mangaDbService.deleteMangaAndChapters(event.mangadexMangaId);
    List<Manga> userMangas = await mangaDbService.getAllMangas();
    List<Chapter> userMangasChapters = await mangaDbService.getAllChapters();

    emit(
      MyMangasRetrivedWithChaptersFromDb(
        userMangaChapterList: userMangasChapters,
        userMangaList: userMangas,
      ),
    );
  }

  void _test(
    MyMangasTestEvent event,
    Emitter<MyMangasState> emit,
  ) async {
    mangaDbService.testTables();
  }

  Future<bool> backgroundNewChapterCheck() async {
    bool status = true;
    AndroidNotif androidNotif = AndroidNotif();
    List<Chapter> apiChapterList = [];
    List<Chapter> dbChapterList = [];
    List<Chapter> chaptersToInsertInDb = [];
    List<String> mangaIdToNotify = [];
    List<Manga> mangaToNotify = [];
    List<Pages> pageListToInsertInDb = [];

    List<Manga> userMangas = await mangaDbService.getAllMangas();

    List<String> userMangasId = [];
    for (Manga manga in userMangas) {
      userMangasId.add(manga.mangadexId);
    }

    try {
      for (var id in userMangasId) {
        dbChapterList.addAll(await mangaDbService.getLatestChapter(id));
        apiChapterList
            .addAll(await mangaInfoService.getMangaChaptersFromMangaId(id));
      }

      for (Chapter dbChapter in dbChapterList) {
        for (Chapter apiChapter in apiChapterList) {
          if (dbChapter.mangadexMangaId == apiChapter.mangadexMangaId) {
            if (dbChapter.number < apiChapter.number) {
              chaptersToInsertInDb.add(apiChapter);
              if (apiChapter.pages != 0) {
                pageListToInsertInDb.addAll(
                  await mangaInfoService.getPagesOfChapterFromApi(
                    chapterId: apiChapter.chapterId,
                    mangadexMangaId: apiChapter.mangadexMangaId,
                  ),
                );
              }
              if (!mangaIdToNotify.contains(apiChapter.mangadexMangaId)) {
                mangaIdToNotify.add(apiChapter.mangadexMangaId);
              }
            }
          }
        }
      }

      await mangaDbService.insertBatchMangaChapters(chaptersToInsertInDb);
      await mangaDbService.insertBatchPages(pageListToInsertInDb);

      for (String id in mangaIdToNotify) {
        mangaToNotify
            .addAll(await mangaDbService.getMangaFromMangadexMangaId(id));
      }

      for (Manga manga in mangaToNotify) {
        for (var chapter in chaptersToInsertInDb) {
          if (chapter.mangadexMangaId == manga.mangadexId) {
            ReceivedNotification notification = ReceivedNotification(
              id: DateTime.now().millisecond,
              title: "Miro Manga Chapter Updater",
              body:
                  "Nouveau chapitre de ${manga.titre} : ${chapter.number.toString().replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")}",
              payload: chapter.chapterId,
            );
            androidNotif.showNotificationWithActions(
              notification,
              "Nouveau chapitre de ${manga.titre} : ${chapter.number.toString().replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")}",
            );
            sleep(const Duration(seconds: 2));
          }
        }
      }

      return status;
    } on Exception catch (e) {
      debugPrint(e.toString());
      status = false;
      return status;
    }
  }

  void chapterRead(Chapter chapter) async {
    if (chapter.chapterRead == 1) {
      await mangaDbService.updateChapterUnread(chapter.chapterId);
    } else {
      await mangaDbService.updateChapterRead(chapter.chapterId);
    }
  }
}
