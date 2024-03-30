import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miro_manga_chapter_update/service/manga_db_service.dart';

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
}
