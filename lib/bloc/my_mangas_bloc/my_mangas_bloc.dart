import 'package:flutter_bloc/flutter_bloc.dart';

import '../../locator.dart';
import '../../model/chapter_model.dart';
import '../../model/manga_model.dart';
import '../../service/manga_db_service.dart';
import '../../service/manga_info_service.dart';
import 'my_mangas_event.dart';
import 'my_mangas_state.dart';

class MyMangasBloc extends Bloc<MyMangasEvent, MyMangasState> {
  MyMangasBloc() : super(MyMangasInitial()) {
    on<GetAllMangasFromDbEvent>(_getAllMangasFromDb);
    on<GetAllMangasChaptersEvent>(_getMangaChaptersFromAPI);
    on<GetAllMangasCoverLinksEvent>(_getAllMangaCoverLinks);
    on<MyMangasTestEvent>(_test);
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
      // emit(AddMangaFailure(error.toString()));
    }
  }

  void _getMangaChaptersFromAPI(
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
      await mangaDbService.updateBatchMangaChapters(chapterList);
      //TODO maybe ajouter un state qui dit que j'ai bien inséré mes chapitres
    } catch (error) {
      // emit(AddMangaFailure(error.toString()));
    }
  }

  void _getAllMangaCoverLinks(
    GetAllMangasCoverLinksEvent event,
    Emitter<MyMangasState> emit,
  ) {}

  void _test(
    MyMangasTestEvent event,
    Emitter<MyMangasState> emit,
  ) {
    mangaDbService.testTables();
  }
}
