import 'package:equatable/equatable.dart';

import '../../model/chapter_model.dart';
import '../../model/manga_model.dart';

final class MyMangasState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class MyMangasInitial extends MyMangasState {
  late final List<Manga> userMangaList;

  @override
  List<Object> get props => [userMangaList];
}

final class MyMangasRetrivedFromDb extends MyMangasState {
  final List<Manga> userMangaList;

  MyMangasRetrivedFromDb({required this.userMangaList});

  @override
  List<Object> get props => [userMangaList];
}

final class MyMangasRetrivedWithChaptersFromDb extends MyMangasState {
  final List<Manga> userMangaList;
  final List<Chapter> userMangaChapterList;

  MyMangasRetrivedWithChaptersFromDb({
    required this.userMangaList,
    required this.userMangaChapterList,
  });

  @override
  List<Object> get props => [userMangaList, userMangaChapterList];
}

final class ChapterReadState extends MyMangasState {
  @override
  List<Object> get props => [];
}
