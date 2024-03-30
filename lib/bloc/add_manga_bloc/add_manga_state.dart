import 'package:equatable/equatable.dart';

import '../../model/manga_model.dart';

final class AddMangaState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class AddMangaInitial extends AddMangaState {
  @override
  List<Object> get props => [];
}

final class MangaFoundByTitleState extends AddMangaState {
  final List<Manga> mangasFound;

  MangaFoundByTitleState({required this.mangasFound});

  @override
  List<Object> get props => [];
}

final class MangaLoadingState extends AddMangaState {
  MangaLoadingState();

  @override
  List<Object> get props => [];
}

final class MangaNotFoundState extends AddMangaState {
  MangaNotFoundState();

  @override
  List<Object> get props => [];
}

final class AddMangaSuccess extends AddMangaState {
  @override
  List<Object> get props => [];
}

final class MangaAlreadyAdded extends AddMangaState {
  @override
  List<Object> get props => [];
}
