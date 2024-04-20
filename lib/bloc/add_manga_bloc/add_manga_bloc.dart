import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miro_manga_chapter_update/service/manga_db_service.dart';

import '../../model/chapter_model.dart';
import '../../model/cover_model.dart';
import '../../service/manga_info_service.dart';
import '../../locator.dart';
import '../../model/manga_model.dart';
import 'add_manga_state.dart';
import 'add_manga_event.dart';

class AddMangaBloc extends Bloc<AddMangaEvent, AddMangaState> {
  AddMangaBloc() : super(AddMangaInitial()) {
    on<AddMangaToDbEvent>(_addMangaToDb);
    on<SearchMangaFromTitleEvent>(_searchMangaFromTitle);
    on<TestEvent>(_test);
  }

  final MangaInfoService mangaInfoService = getIt<MangaInfoService>();
  final MangaDbService mangaDbService = getIt<MangaDbService>();

  void _addMangaToDb(
    AddMangaToDbEvent event,
    Emitter<AddMangaState> emit,
  ) async {
    if (event.manga.mangadexId.isEmpty) {
      Fluttertoast.showToast(
          msg: "Recherchez un manga avant de le sauvegarder",
          backgroundColor: Colors.red[300],
          textColor: Colors.white,
          fontSize: 16);
      return;
    }
    try {
      int insertStatus = await mangaDbService.insertManga(event.manga);
      await _getMangaChaptersFromApiAndInsertInDb(event.manga);
      if (insertStatus == 0) {
        emit(MangaAlreadyAdded());
      } else {
        emit(AddMangaSuccess());
      }
    } catch (error) {
      // emit(AddMangaFailure(error.toString()));
    }
  }

  void _searchMangaFromTitle(
    SearchMangaFromTitleEvent event,
    Emitter<AddMangaState> emit,
  ) async {
    try {
      emit(MangaLoadingState());
      final List<Manga> mangasFound =
          await mangaInfoService.getMangaInfoFromTitle(event.title);

      await _getAllMangaCoverLinks(mangasFound);

      emit(
        MangaFoundByTitleState(mangasFound: mangasFound),
      );
    } catch (error) {
      emit(MangaNotFoundState());
    }
  }

  void _test(
    TestEvent event,
    Emitter<AddMangaState> emit,
  ) {
    mangaDbService.testTables();
  }

  Future<List<Manga>> _getAllMangaCoverLinks(List<Manga> mangasFound) async {
    for (var manga in mangasFound) {
      if (manga.coverId != null && manga.coverLink == null) {
        Cover cover =
            await mangaInfoService.getCoverFromCoverId(manga.coverId!);
        String coverLink =
            "https://mangadex.org/covers/${manga.mangadexId}/${cover.data?.attributes?.fileName}";
        manga.coverLink = coverLink;
      }
    }
    return mangasFound;
  }

  Future<void> _getMangaChaptersFromApiAndInsertInDb(Manga manga) async {
    try {
      List<Chapter> chapterList =
          await mangaInfoService.getMangaChaptersFromMangaId(manga.mangadexId);
      await mangaDbService.insertBatchMangaChapters(chapterList);
    } catch (error) {
      debugPrint("_getMangaChaptersFromAPI error : ${error.toString()}");
    }
  }
}
