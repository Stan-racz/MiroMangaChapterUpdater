import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/manga_info_service.dart';
import '../../locator.dart';
import '../../model/manga_model.dart';
import 'add_manga_state.dart';
import 'add_manga_event.dart';

class AddMangaBloc extends Bloc<AddMangaEvent, AddMangaState> {
  AddMangaBloc() : super(AddMangaInitial()) {
    on<AddMangaToDbEvent>(_addMangaToDb);
    on<SearchMangaFromTitleEvent>(_searchMangaFromTitle);
  }

  final MangaInfoService mangaInfoService = getIt<MangaInfoService>();

  void _addMangaToDb(
    AddMangaToDbEvent event,
    Emitter<AddMangaState> emit,
  ) async {
    // emit(AddMangaLoading());

    try {
      // Ajoute le manga à la base de données

      // emit(AddMangaSuccess());
    } catch (error) {
      // emit(AddMangaFailure(error.toString()));
    }
  }

  void _searchMangaFromTitle(
    SearchMangaFromTitleEvent event,
    Emitter<AddMangaState> emit,
  ) async {
    try {
      emit(MangaLoadingState(
        manga: Manga(
          id: "",
          description: "",
          titre: "",
          status: "",
          annee: "",
        ),
      ));
      // Cherche les infos du manga via son titre
      final Manga manga =
          await mangaInfoService.getMangaInfoFromTitle(event.title);
      emit(
        MangaFoundByTitleState(manga: manga),
      );
    } catch (error) {
      emit(MangaNotFoundState(error.toString()));
    }
  }
}
