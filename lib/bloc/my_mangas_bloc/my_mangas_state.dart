import 'package:equatable/equatable.dart';

import '../../model/chapter_model.dart';
import '../../model/manga_model.dart';

final class MyMangasState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

// ignore: must_be_immutable
final class MyMangasInitial extends MyMangasState {
  List<Manga>? userMangaList;

  @override
  List<Object> get props => [];
}

final class MyMangasRetrivedFromDb extends MyMangasState {
  final List<Manga> userMangaList;

  MyMangasRetrivedFromDb({required this.userMangaList});

  @override
  List<Object> get props => [userMangaList];
}

final class MyMangasChapterStatusUpdatedFromDb extends MyMangasState {
  final List<Chapter> userChapterList;

  MyMangasChapterStatusUpdatedFromDb({required this.userChapterList});

  @override
  List<Object> get props => [userChapterList];
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

final class MangaDeletedState extends MyMangasState {
  final List<Manga> userMangaList;
  final List<Chapter> userMangaChapterList;

  MangaDeletedState({
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

final class MangadexDown extends MyMangasState {
  MangadexDown();

  @override
  List<Object> get props => [];
}
