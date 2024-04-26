import 'package:flutter_bloc/flutter_bloc.dart';

import '../../locator.dart';
import '../../model/pages_model.dart';
import '../../service/manga_db_service.dart';
import '../../service/manga_info_service.dart';
import 'reader_event.dart';
import 'reader_state.dart';

class ReaderBloc extends Bloc<ReaderEvent, ReaderState> {
  ReaderBloc() : super(ChapterPagesLoading()) {
    on<GetPagesFromDb>(_getAllChapterPagesFromDb);
  }

  final MangaInfoService mangaInfoService = getIt<MangaInfoService>();
  final MangaDbService mangaDbService = getIt<MangaDbService>();

  void _getAllChapterPagesFromDb(
    GetPagesFromDb event,
    Emitter<ReaderState> emit,
  ) async {
    emit(ChapterPagesLoading());
    List<Pages> pageList =
        await mangaDbService.getPagesFromChapterId(event.chapterId);

    List<String> pagesLink = [];
    for (var page in pageList) {
      pagesLink
          .add("https://uploads.mangadex.org/data/${page.hash}/${page.data}");
    }
    emit(PagesLoaded(pagesLink));
  }
}
