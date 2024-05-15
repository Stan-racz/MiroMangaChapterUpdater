import 'package:miro_manga_chapter_update/bloc/my_mangas_bloc/my_mangas_bloc.dart';
import '../utils/locator.dart' as loc;

class ChapterCheckBackGroundWorker {
  ChapterCheckBackGroundWorker();

  static Future<bool> checkNewChapters() async {
    await loc.setupLocator();
    return loc.getIt<MyMangasBloc>().backgroundNewChapterCheck();
  }
}
